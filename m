Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEC23391F22
	for <lists+linux-nfs@lfdr.de>; Wed, 26 May 2021 20:30:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232577AbhEZSbr (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 26 May 2021 14:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235533AbhEZSbq (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 26 May 2021 14:31:46 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E91BC061574
        for <linux-nfs@vger.kernel.org>; Wed, 26 May 2021 11:30:12 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 903F8201A; Wed, 26 May 2021 14:30:11 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 903F8201A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1622053811;
        bh=qJbsuvcoetswSe41//9C5LpdNVam97sKOsVmVzddBXs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p5bc0rItNDjzK2SdUSFkwj++8x8HSjfsgr4Sf3KTYY/qlmhLfg0dZRSbGI/BI60lx
         e8L7P2or4IsYQnXAn7IJ2UI6L/wTI65wqHg8ERgknlM6auuCTn5n3QPkwwBHEByA2r
         Eq1DqOMkR2vq6ZxBPkm5nZYnbS3XiyqKW8+acxxs=
Date:   Wed, 26 May 2021 14:30:11 -0400
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Dave Wysochanski <dwysocha@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 1/1] nfsd4: Expose the callback address and state of
 each NFS4 client
Message-ID: <20210526183011.GA7823@fieldses.org>
References: <1621283385-24390-1-git-send-email-dwysocha@redhat.com>
 <1621283385-24390-2-git-send-email-dwysocha@redhat.com>
 <20210525205845.GB4162@fieldses.org>
 <6C2F8C95-E29F-4BB3-9127-6ED5D825ACB7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6C2F8C95-E29F-4BB3-9127-6ED5D825ACB7@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, May 25, 2021 at 09:48:38PM +0000, Chuck Lever III wrote:
> 
> 
> > On May 25, 2021, at 4:58 PM, Bruce Fields <bfields@fieldses.org> wrote:
> > 
> > When I run trace-cmd report I get output like:
> > 
> >  [nfsd:nfsd_cb_state] function cb_state2str not defined
> >  [nfsd:nfsd_cb_shutdown] function cb_state2str not defined
> >  [nfsd:nfsd_cb_probe] function cb_state2str not defined
> >  [nfsd:nfsd_cb_lost] function cb_state2str not defined
> > 
> > I don't know how this is supposed to work.  Is it OK for tracepoint definitions
> > to reference kernel functions if they're defined in the right way somehow?  If
> > not, I don't know what the solution would be for sharing this--define a macro
> > that expands to the array literal and use that in both places?  Or maybe just
> > live with the the redundancy.
> 
> Living with the redundancy is OK with me.

OK, I'll revert back to Dave's first version of this patch.

--b.

diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
index 49c052243b5c..89a7cada334d 100644
--- a/fs/nfsd/nfs4state.c
+++ b/fs/nfsd/nfs4state.c
@@ -2357,6 +2357,21 @@ static void seq_quote_mem(struct seq_file *m, char *data, int len)
 	seq_printf(m, "\"");
 }
 
+static const char *cb_state_str(int state)
+{
+	switch (state) {
+		case NFSD4_CB_UP:
+			return "UP";
+		case NFSD4_CB_UNKNOWN:
+			return "UNKNOWN";
+		case NFSD4_CB_DOWN:
+			return "DOWN";
+		case NFSD4_CB_FAULT:
+			return "FAULT";
+	}
+	return "UNDEFINED";
+}
+
 static int client_info_show(struct seq_file *m, void *v)
 {
 	struct inode *inode = m->private;
@@ -2385,6 +2400,8 @@ static int client_info_show(struct seq_file *m, void *v)
 		seq_printf(m, "\nImplementation time: [%lld, %ld]\n",
 			clp->cl_nii_time.tv_sec, clp->cl_nii_time.tv_nsec);
 	}
+	seq_printf(m, "callback state: %s\n", cb_state_str(clp->cl_cb_state));
+	seq_printf(m, "callback address: %pISpc\n", &clp->cl_cb_conn.cb_addr);
 	drop_client(clp);
 
 	return 0;
-- 
1.8.3.1

