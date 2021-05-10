Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ECA4C379328
	for <lists+linux-nfs@lfdr.de>; Mon, 10 May 2021 17:53:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231609AbhEJPyx (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 10 May 2021 11:54:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:44754 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231753AbhEJPyx (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 10 May 2021 11:54:53 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id D8998615FF;
        Mon, 10 May 2021 15:53:47 +0000 (UTC)
Subject: [PATCH RFC 21/21] NFSD: Add tracepoints to observe clientID activity
From:   Chuck Lever <chuck.lever@oracle.com>
To:     dwysocha@redhat.com, bfields@fieldses.org
Cc:     linux-nfs@vger.kernel.org
Date:   Mon, 10 May 2021 11:53:47 -0400
Message-ID: <162066202717.94415.8666073108309704792.stgit@klimt.1015granger.net>
In-Reply-To: <162066179690.94415.203187037032448300.stgit@klimt.1015granger.net>
References: <162066179690.94415.203187037032448300.stgit@klimt.1015granger.net>
User-Agent: StGit/1.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

We are especially interested in capturing clientID conflicts.

Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
---
 fs/nfsd/nfs4state.c |    9 +++++++--
 fs/nfsd/trace.h     |   37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 44 insertions(+), 2 deletions(-)

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index a61601fe422a..528cabffa1e9 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -3180,6 +3180,7 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 			}
 			/* case 6 */
 			exid->flags |= EXCHGID4_FLAG_CONFIRMED_R;
+			trace_nfsd_clid_existing(conf);
 			goto out_copy;
 		}
 		if (!creds_match) { /* case 3 */
@@ -3188,15 +3189,18 @@ nfsd4_exchange_id(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 				trace_nfsd_clid_cred_mismatch(conf, rqstp);
 				goto out;
 			}
+			trace_nfsd_clid_new(new);
 			goto out_new;
 		}
 		if (verfs_match) { /* case 2 */
 			conf->cl_exchange_flags |= EXCHGID4_FLAG_CONFIRMED_R;
+			trace_nfsd_clid_existing(conf);
 			goto out_copy;
 		}
 		/* case 5, client reboot */
 		trace_nfsd_clid_verf_mismatch(conf, rqstp, &verf);
 		conf = NULL;
+		trace_nfsd_clid_new(new);
 		goto out_new;
 	}
 
@@ -3996,10 +4000,12 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 		if (same_verf(&conf->cl_verifier, &clverifier)) {
 			copy_clid(new, conf);
 			gen_confirm(new, nn);
+			trace_nfsd_clid_existing(new);
 		} else
 			trace_nfsd_clid_verf_mismatch(conf, rqstp,
 						      &clverifier);
-	}
+	} else
+		trace_nfsd_clid_new(new);
 	new->cl_minorversion = 0;
 	gen_callback(new, setclid, rqstp);
 	add_to_unconfirmed(new);
@@ -4017,7 +4023,6 @@ nfsd4_setclientid(struct svc_rqst *rqstp, struct nfsd4_compound_state *cstate,
 	return status;
 }
 
-
 __be32
 nfsd4_setclientid_confirm(struct svc_rqst *rqstp,
 			struct nfsd4_compound_state *cstate,
diff --git a/fs/nfsd/trace.h b/fs/nfsd/trace.h
index 523045c37749..6ddff13e3181 100644
--- a/fs/nfsd/trace.h
+++ b/fs/nfsd/trace.h
@@ -626,6 +626,43 @@ TRACE_EVENT(nfsd_clid_verf_mismatch,
 	)
 );
 
+DECLARE_EVENT_CLASS(nfsd_clid_class,
+	TP_PROTO(const struct nfs4_client *clp),
+	TP_ARGS(clp),
+	TP_STRUCT__entry(
+		__field(u32, cl_boot)
+		__field(u32, cl_id)
+		__array(unsigned char, addr, sizeof(struct sockaddr_in6))
+		__field(unsigned long, flavor)
+		__array(unsigned char, verifier, NFS4_VERIFIER_SIZE)
+		__field(unsigned int, namelen)
+		__dynamic_array(unsigned char, name, clp->cl_name.len)
+	),
+	TP_fast_assign(
+		memcpy(__entry->addr, &clp->cl_addr,
+			sizeof(struct sockaddr_in6));
+		__entry->flavor = clp->cl_cred.cr_flavor;
+		memcpy(__entry->verifier, (void *)&clp->cl_verifier,
+		       NFS4_VERIFIER_SIZE);
+		__entry->namelen = clp->cl_name.len;
+		memcpy(__get_dynamic_array(name), clp->cl_name.data,
+			clp->cl_name.len);
+	),
+	TP_printk("addr=%pISpc name='%.*s' verifier=0x%s flavor=%s client=%08x:%08x\n",
+		__entry->addr, __entry->namelen, __get_str(name),
+		__print_hex_str(__entry->verifier, NFS4_VERIFIER_SIZE),
+		show_nfsd_authflavor(__entry->flavor),
+		__entry->cl_boot, __entry->cl_id)
+);
+
+#define DEFINE_CLID_EVENT(name) \
+DEFINE_EVENT(nfsd_clid_class, nfsd_clid_##name, \
+	TP_PROTO(const struct nfs4_client *clp), \
+	TP_ARGS(clp))
+
+DEFINE_CLID_EVENT(new);
+DEFINE_CLID_EVENT(existing);
+
 /*
  * from fs/nfsd/filecache.h
  */


