Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3E26589821
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Aug 2022 09:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239104AbiHDHHv (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Aug 2022 03:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239098AbiHDHHv (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 Aug 2022 03:07:51 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57B0F14088
        for <linux-nfs@vger.kernel.org>; Thu,  4 Aug 2022 00:07:49 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 95E2620B5A;
        Thu,  4 Aug 2022 07:07:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659596867;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YvFr4zTnt14JlVaUqO+3d/Sncgi9+1A8eOOSBpbi6RU=;
        b=uEWG+KPBqEqe8SBCMgZtVrao3zdY+nfAfGtYEVJ6/ghSymw912/5iXqVb+yIaZUPUjBa3x
        Ba6RrIqvCZfz5zMRYUCmiD5AUui5K/qr+hEcHfJdS/oTjzwx9mOB3lYRzz/T3xwZhddAS1
        sRqPzZLwH2AP32Lx67i1e0swUd0sekg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659596867;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YvFr4zTnt14JlVaUqO+3d/Sncgi9+1A8eOOSBpbi6RU=;
        b=eWBlfeSYCqDperXUA3ykYOBEf1XrRzAJ9V41gC1myl3Qz1+CY9Ma6SG00evcylfN64UT2k
        Eu4YEe0VIAytW/Bg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3F8F51348A;
        Thu,  4 Aug 2022 07:07:47 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id YKEbDUNw62KJDgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 04 Aug 2022 07:07:47 +0000
Date:   Thu, 4 Aug 2022 09:07:45 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     ltp@lists.linux.it
Cc:     linux-nfs@vger.kernel.org, Martin Doucha <martin.doucha@suse.com>,
        Li Wang <liwang@redhat.com>, Cyril Hrubis <chrubis@suse.cz>
Subject: Re: [PATCH v2 5/9] tst_test.sh: Add $TST_ALL_FILESYSTEMS
Message-ID: <YutwQfLa2O01OyNE@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20220609214223.4608-1-pvorel@suse.cz>
 <20220609214223.4608-6-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220609214223.4608-6-pvorel@suse.cz>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi all,

I wonder if we want to sort filesystems:

-for _tst_fs in $(tst_supported_fs); do
+for _tst_fs in $(tst_supported_fs | sort); do

or even -u (as uniq).

Martin used it in testcases/misc/lvm/prepare_lvm.sh, but IMHO it should not be
needed: looping over fs_type_whitelist() should be always the same.

FS_LIST=`tst_supported_fs | sort -u`

Therefore I'd remove it (don't use unnecessary dependencies - be nice for people
with minimal environment):

Kind regards,
Petr
