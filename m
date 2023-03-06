Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A176AC7D3
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Mar 2023 17:25:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbjCFQZ2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 6 Mar 2023 11:25:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjCFQZJ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 6 Mar 2023 11:25:09 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 919946EA6
        for <linux-nfs@vger.kernel.org>; Mon,  6 Mar 2023 08:23:52 -0800 (PST)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 68D9522325;
        Mon,  6 Mar 2023 16:16:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1678119383; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O2B4n+BOmp9iBp8Z4MiAzVK942vdeo5jGJXB6QCegks=;
        b=ufn4QLKKoU0k8XE/3LsFB27s8xilm82sERt/mVX/zLoTJVuZ+1Z63WyEzwujtAdOH2lpCH
        uscZ71yqwVtvw/scfLSv4WWmN5DOlmrib9IOzsCnSDJoQi5ACQy3SS8iOmaYppib2CuiuH
        ro0sZpYMRH0LwVCN33GoADbXQD1Dok4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1678119383;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=O2B4n+BOmp9iBp8Z4MiAzVK942vdeo5jGJXB6QCegks=;
        b=Sle+Ke/pjtP4/qMU6Ea8T05dlDGMJGtGvBS3Xx/mOEDdX0DqzCE+HZlTrErj7a+caCtYpk
        al0BJlcf2Vzx8uCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 5A0AA13513;
        Mon,  6 Mar 2023 16:16:23 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 0ZP0FdcRBmQESQAAMHmgww
        (envelope-from <jack@suse.cz>); Mon, 06 Mar 2023 16:16:23 +0000
Received: by quack3.suse.cz (Postfix, from userid 1000)
        id D81C1A064F; Mon,  6 Mar 2023 17:16:22 +0100 (CET)
Date:   Mon, 6 Mar 2023 17:16:22 +0100
From:   Jan Kara <jack@suse.cz>
To:     Chuck Lever <cel@kernel.org>
Cc:     linux-nfs@vger.kernel.org, jack@suse.de, flole@flole.de
Subject: Re: [PATCH] NFSD: Protect against filesystem freezing
Message-ID: <20230306161622.olratc7w5df4gc2d@quack3>
References: <167811742782.1909.380332356774647144.stgit@bazille.1015granger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <167811742782.1909.380332356774647144.stgit@bazille.1015granger.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon 06-03-23 10:43:47, Chuck Lever wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> Flole observes this WARNING on occasion:
> 
> [1210423.486503] WARNING: CPU: 8 PID: 1524732 at fs/ext4/ext4_jbd2.c:75 ext4_journal_check_start+0x68/0xb0
> 
> Reported-by: <flole@flole.de>
> Suggested-by: Jan Kara <jack@suse.cz>
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217123
> Fixes: 73da852e3831 ("nfsd: use vfs_iter_read/write")
> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>

Looks good to me. Feel free to add:

Reviewed-by: Jan Kara <jack@suse.cz>

								Honza

> ---
>  fs/nfsd/vfs.c |    2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/nfsd/vfs.c b/fs/nfsd/vfs.c
> index 21d5209f6e04..ba34a31a7c70 100644
> --- a/fs/nfsd/vfs.c
> +++ b/fs/nfsd/vfs.c
> @@ -1104,7 +1104,9 @@ nfsd_vfs_write(struct svc_rqst *rqstp, struct svc_fh *fhp, struct nfsd_file *nf,
>  	since = READ_ONCE(file->f_wb_err);
>  	if (verf)
>  		nfsd_copy_write_verifier(verf, nn);
> +	file_start_write(file);
>  	host_err = vfs_iter_write(file, &iter, &pos, flags);
> +	file_end_write(file);
>  	if (host_err < 0) {
>  		nfsd_reset_write_verifier(nn);
>  		trace_nfsd_writeverf_reset(nn, rqstp, host_err);
> 
> 
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
