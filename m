Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D77CB4A6B03
	for <lists+linux-nfs@lfdr.de>; Wed,  2 Feb 2022 05:44:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232117AbiBBEoX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 1 Feb 2022 23:44:23 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:42426 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232035AbiBBEoU (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 1 Feb 2022 23:44:20 -0500
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id D96521F37C;
        Wed,  2 Feb 2022 04:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1643777059; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BDiQOBR4POP3s9FAkg18U5MsJgq2aSf0QTjjYdD3Pao=;
        b=fcvuvmatr5yfMT3sd9qNK8zL1locQ33Ddb4SQUx73da88dkLOHmQ1ckM6v74ev5D6o9JuF
        8j44MU8uZebQm0aohw4KO5dTyW9QiRCRH2uYlRXvqcmXO1RjKZ6gnL6dRXfgke0/ulQ2Kv
        r0qavW7xs2xIaUaTFFTuJ7nv6cj/Rpc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1643777059;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BDiQOBR4POP3s9FAkg18U5MsJgq2aSf0QTjjYdD3Pao=;
        b=SLjAi/T9FJJ9gPzg9eWn+rG0brKkdy8LEqKdeiKprAcq681tR9z1P7L0KokwNHjCWquH0f
        ChPAb8o3gLaNQ/Dg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 379DE13B92;
        Wed,  2 Feb 2022 04:44:17 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id mNhyOCEM+mEMWAAAMHmgww
        (envelope-from <neilb@suse.de>); Wed, 02 Feb 2022 04:44:17 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
MIME-Version: 1.0
From:   "NeilBrown" <neilb@suse.de>
To:     "inoguchi.yuki@fujitsu.com" <inoguchi.yuki@fujitsu.com>
Cc:     "'bfields@fieldses.org'" <bfields@fieldses.org>,
        "'Trond Myklebust'" <trondmy@hammerspace.com>,
        "'linux-nfs@vger.kernel.org'" <linux-nfs@vger.kernel.org>,
        "'mbenjami@redhat.com'" <mbenjami@redhat.com>
Subject: RE: client caching and locks
In-reply-to: =?utf-8?q?=3COSZPR01MB7050DF6073AB2EC4F82A589AEF279=40OSZPR01MB?=
 =?utf-8?q?7050=2Ejpnprd01=2Eprod=2Eoutlook=2Ecom=3E?=
References: <20201001214749.GK1496@fieldses.org>,
 <CAKOnarndL1-u5jGG2VAENz2bEc9wsERH6rGTbZeYZy+WyAUk-w@mail.gmail.com>,
 <20201006172607.GA32640@fieldses.org>,
 <164066831190.25899.16641224253864656420@noble.neil.brown.name>,
 <20220103162041.GC21514@fieldses.org>, =?utf-8?q?=3COSZPR01MB7050F9737016E8?=
 =?utf-8?q?E3F0FD5255EF4A9=40OSZPR01MB7050=2Ejpnprd01=2Eprod=2Eoutlook=2Ecom?=
 =?utf-8?q?=3E=2C?=
 <03e4cc01e9e66e523474c10846ee22147b78addf.camel@hammerspace.com>,
 <20220104153205.GA7815@fieldses.org>,
 <1257915fc5fd768e6c1c70fd3e8e3ed3fa1dc33e.camel@hammerspace.com>, 
 =?utf-8?q?=3COSZPR01MB7050C5098D47514FFEC2DA82EF4B9=40OSZPR01MB7050=2Ejpnpr?=
 =?utf-8?q?d01=2Eprod=2Eoutlook=2Ecom=3E=2C?=
 <20220105220353.GF25384@fieldses.org>,
 <164176553564.25899.8328729314072677083@noble.neil.brown.name>, =?utf-8?q??=
 =?utf-8?q?=3COSZPR01MB7050A3B0D15D38420532CD31EF579=40OSZPR01MB7050=2Ejpnpr?=
 =?utf-8?q?d01=2Eprod=2Eoutlook=2Ecom=3E=2C?=
 <164245842205.24166.5326728089527364990@noble.neil.brown.name>, =?utf-8?q??=
 =?utf-8?q?=3COSZPR01MB7050DF6073AB2EC4F82A589AEF279=40OSZPR01MB7050=2Ejpnpr?=
 =?utf-8?q?d01=2Eprod=2Eoutlook=2Ecom=3E?=
Date:   Wed, 02 Feb 2022 15:44:14 +1100
Message-id: <164377705404.1660.1273338182990772730@noble.neil.brown.name>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 02 Feb 2022, inoguchi.yuki@fujitsu.com wrote:
> > I don't think that case adds anything interesting.  When the file is
> > closed, the lock is dropped.  If there were any writes without a
> > delegation, then the changeid isn't a reliable indication that no other
> > client wrote.  So the cache must be dropped.
> 
> I've understood it. 
> 
> I've made the patch based on your idea. It invalidates the cache
> after a client without write-delegation sends CLOSE call.
> My Open MPI test program confirmed that this fix resolves the problem.
> 
> The patch is as follows. What do you think?

This is a bit too heavy-handed.  It invalidates too often.

I would make 2 changes.
 1/ invalidate when opening a file, rather than when closing.
   This fits better with the understanding of close-to-open consistency
   that we flush writes when closing and verify the cache when opening
 2/ I would be more careful about determining exactly when the
   invalidation might be needed.

In nfs_post_op_updatE_inode() there is the code:

	if ((fattr->valid & NFS_ATTR_FATTR_CHANGE) != 0 &&
			(fattr->valid & NFS_ATTR_FATTR_PRECHANGE) == 0) {
		fattr->pre_change_attr = inode_peek_iversion_raw(inode);
		fattr->valid |= NFS_ATTR_FATTR_PRECHANGE;
	}

This effectively says "if we don't have the PRECHANGE number, then take
the current version number, and pretend that we do have the PRECHANGE
number.

NFSv3 can provide a PRECHANGE number because the protocol allows
pre/post attrs to be atomic.  NFSv4 never sets PRECHANGE because the
protocol never guarantees atomicity of pre/post attrs (For files).

So it is at the point in the code where the cache on the client might
become inconsistent with the data on the server.  This is not a serious
inconsistency and doesn't need to be resolved immediately.  But I think
it should be handled the next time some application opens the file.

I think that when this branch of code is run, we should set a flag on
the inode "NFS_ATTR_MIGHT_BE_INCONSISTENT" (or something like that).
Then when we open a file, if that flag is set then we clear it and set
NFS_INO_INVALID_DATA and maybe NFS_INO_REVAL_PAGECACHE (I don't recall how
those two relate to each other).

I assume that code doesn't end up running when you write to a file for
which you have a delegation, but I'm not at all certain - we would have
to check.

NeilBrown
