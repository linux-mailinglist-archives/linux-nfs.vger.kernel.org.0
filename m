Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9439A589EB6
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Aug 2022 17:33:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234035AbiHDPd2 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Aug 2022 11:33:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231909AbiHDPd2 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 Aug 2022 11:33:28 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB259FD11
        for <linux-nfs@vger.kernel.org>; Thu,  4 Aug 2022 08:33:26 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 684BC4E623;
        Thu,  4 Aug 2022 15:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659627205; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XgqAvDRGRKbyzelNP7eRPGBQHRHBDH17MuR91kEvAys=;
        b=Gmly/p+Ar0ShQC6kWulggnRp4Lh0zyDvgHJB6pmzKZritUspzTw4+XwwMq2GeY2Pr1jWyK
        myPWm2gzAbybog+IfNAjp392JvAjh8o3gvgkIn8hWYvlVNBar2QhAzdDzF1/TnLM/j/a4J
        YTn8WCN2g3p7Q9JxjAliQLXO3PIrFBw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659627205;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XgqAvDRGRKbyzelNP7eRPGBQHRHBDH17MuR91kEvAys=;
        b=lUhwujJL5Kflfa6QIGEfioQ0yn4lN90EhuJ78JdOyBGGF+J8CQULYclm8tOUwGICwC4qxl
        6ysdL2BAt5pH5xCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4765813A94;
        Thu,  4 Aug 2022 15:33:25 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id rZRxEMXm62IlFAAAMHmgww
        (envelope-from <mdoucha@suse.cz>); Thu, 04 Aug 2022 15:33:25 +0000
Message-ID: <2fd92c3d-a67e-3cfc-aaf8-ca35176cf399@suse.cz>
Date:   Thu, 4 Aug 2022 17:33:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/1] generate_lvm_runfile.sh: Fix bashism
Content-Language: en-US
To:     Petr Vorel <pvorel@suse.cz>, ltp@lists.linux.it
Cc:     linux-nfs@vger.kernel.org, Cyril Hrubis <chrubis@suse.cz>
References: <20220803175752.19015-1-pvorel@suse.cz>
From:   Martin Doucha <mdoucha@suse.cz>
In-Reply-To: <20220803175752.19015-1-pvorel@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,
`trap ... EXIT` cannot be used to emulate `trap ... ERR`. The latter
behaves as if every command/pipeline in the script (except conditions)
were wrapped in ROD. So `trap ... ERR` will trigger exit on any failure,
while `trap ... EXIT` will let the script continue after all errors and
then check exit code of only the very last command. That's not what we
want here.

On 03. 08. 22 19:57, Petr Vorel wrote:
> ERR is not on dash (tested on 0.5.11).
> 
> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  testcases/misc/lvm/generate_lvm_runfile.sh | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/testcases/misc/lvm/generate_lvm_runfile.sh b/testcases/misc/lvm/generate_lvm_runfile.sh
> index 72b286a69..5bf5d91d6 100755
> --- a/testcases/misc/lvm/generate_lvm_runfile.sh
> +++ b/testcases/misc/lvm/generate_lvm_runfile.sh
> @@ -13,7 +13,7 @@ LVM_TMPDIR="$LVM_DIR/ltp/growfiles"
>  
>  generate_runfile()
>  {
> -	trap 'tst_brk TBROK "Cannot create LVM runfile"' ERR
> +	trap '[ $? -eq 0 ] && exit 0 || tst_brk TBROK "Cannot create LVM runfile"' EXIT
>  	INFILE="$LTPROOT/testcases/data/lvm/runfile.tpl"
>  	OUTFILE="$LTPROOT/runtest/lvm.local"
>  	FS_LIST=`tst_supported_fs`


-- 
Martin Doucha   mdoucha@suse.cz
QA Engineer for Software Maintenance
SUSE LINUX, s.r.o.
CORSO IIa
Krizikova 148/34
186 00 Prague 8
Czech Republic
