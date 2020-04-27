Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B0D341BB15D
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2020 00:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgD0WHy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 27 Apr 2020 18:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726233AbgD0WHy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 27 Apr 2020 18:07:54 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00::f03c:91ff:fe50:41d6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23278C0610D5
        for <linux-nfs@vger.kernel.org>; Mon, 27 Apr 2020 15:07:54 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id BD9753AF; Mon, 27 Apr 2020 18:07:52 -0400 (EDT)
Date:   Mon, 27 Apr 2020 18:07:52 -0400
To:     Trond Myklebust <trondmy@hammerspace.com>
Cc:     "olga.kornievskaia@gmail.com" <olga.kornievskaia@gmail.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH 1/1] NFSv4.1: fix lone sequence transport assignment
Message-ID: <20200427220752.GG31277@fieldses.org>
References: <20200417151540.22111-1-olga.kornievskaia@gmail.com>
 <9c6c72708f360f543e2b8caaf56cc074aa825c96.camel@hammerspace.com>
 <CAN-5tyHQ_Gs-HmWLdbQYz1o8UyB2jv_oD2EtJP94qgtrfeK52Q@mail.gmail.com>
 <7dd1b9300d2a0ec1a31fb3879c62a94f535ccad5.camel@hammerspace.com>
 <CAN-5tyEbi8Z8bxU1enkkhjAyJj-nb9=j33xcLi7FE2+A79-qng@mail.gmail.com>
 <52b65780986192bb635638d4615176bbc1ad579c.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <52b65780986192bb635638d4615176bbc1ad579c.camel@hammerspace.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Fri, Apr 17, 2020 at 04:53:32PM +0000, Trond Myklebust wrote:
> In RFC5661, Section 18.34.3 I found the following normative text:
> 
>    Invoking BIND_CONN_TO_SESSION on a connection already associated with
>    the specified session has no effect, and the server MUST respond with
>    NFS4_OK, unless the client is demanding changes to the set of
>    channels the connection is associated with.  If so, the server MUST
>    return NFS4ERR_INVAL.

Hm, I should fix that.

(Totally untested.)

--b.

commit cd66e66c4ce7
Author: J. Bruce Fields <bfields@redhat.com>
Date:   Mon Apr 27 17:59:01 2020 -0400

    nfsd: handle repeated BIND_CONN_TO_SESSION
    
    If the client attempts BIND_CONN_TO_SESSION on an already bound
    connection, it should be either a no-op or an error.
    
    Signed-off-by: J. Bruce Fields <bfields@redhat.com>

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a50c045fe7c5..73f821f65ce8 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3483,6 +3483,45 @@ __be32 nfsd4_backchannel_ctl(struct svc_rqst *rqstp,
 	return nfs_ok;
 }
 
+static struct nfsd4_conn *__nfsd4_find_conn(struct svc_xprt *xpt, struct nfsd4_session *s)
+{
+	struct nfsd4_conn *c;
+
+	list_for_each_entry(c, &s->se_conns, cn_persession) {
+		if (c->cn_xprt == xpt) {
+			return c;
+		}
+	}
+	return NULL;
+}
+
+static __be32 nfsd4_match_existing_connection(struct svc_rqst *rqst,
+				struct nfsd4_session *session, u32 req)
+{
+	struct nfs4_client *clp = session->se_client;
+	struct svc_xprt *xpt = rqst->rq_xprt;
+	struct nfsd4_conn *c;
+	__be32 status;
+
+	/* Following the last paragraph of RFC 5661 Section 18.34.3: */
+	spin_lock(&clp->cl_lock);
+	c = __nfsd4_find_conn(xpt, session);
+	if (!c)
+		status = nfserr_noent;
+	else if (req == c->cn_flags)
+		status = nfs_ok;
+	else if (req == NFS4_CDFC4_FORE_OR_BOTH &&
+				c->cn_flags != NFS4_CDFC4_BACK)
+		status = nfs_ok;
+	else if (req == NFS4_CDFC4_BACK_OR_BOTH &&
+				c->cn_flags != NFS4_CDFC4_FORE)
+		status = nfs_ok;
+	else
+		status = nfserr_inval;
+	spin_unlock(&clp->cl_lock);
+	return status;
+}
+
 __be32 nfsd4_bind_conn_to_session(struct svc_rqst *rqstp,
 		     struct nfsd4_compound_state *cstate,
 		     union nfsd4_op_u *u)
@@ -3504,6 +3543,9 @@ __be32 nfsd4_bind_conn_to_session(struct svc_rqst *rqstp,
 	status = nfserr_wrong_cred;
 	if (!nfsd4_mach_creds_match(session->se_client, rqstp))
 		goto out;
+	status = nfsd4_match_existing_connection(rqstp, session, bcts->dir);
+	if (status == nfs_ok || status == nfserr_inval)
+		goto out;
 	status = nfsd4_map_bcts_dir(&bcts->dir);
 	if (status)
 		goto out;
@@ -3569,18 +3611,6 @@ nfsd4_destroy_session(struct svc_rqst *r, struct nfsd4_compound_state *cstate,
 	return status;
 }
 
-static struct nfsd4_conn *__nfsd4_find_conn(struct svc_xprt *xpt, struct nfsd4_session *s)
-{
-	struct nfsd4_conn *c;
-
-	list_for_each_entry(c, &s->se_conns, cn_persession) {
-		if (c->cn_xprt == xpt) {
-			return c;
-		}
-	}
-	return NULL;
-}
-
 static __be32 nfsd4_sequence_check_conn(struct nfsd4_conn *new, struct nfsd4_session *ses)
 {
 	struct nfs4_client *clp = ses->se_client;
