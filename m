Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B20B58A1EC
	for <lists+linux-nfs@lfdr.de>; Thu,  4 Aug 2022 22:25:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232290AbiHDUZU (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 4 Aug 2022 16:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238472AbiHDUZT (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 4 Aug 2022 16:25:19 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E628D6353
        for <linux-nfs@vger.kernel.org>; Thu,  4 Aug 2022 13:25:17 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 51CB9225F5;
        Thu,  4 Aug 2022 20:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1659644673;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mX2pVowatUGhma8lkomeb+U7Bp7NNQJSP4qd6j4+tsw=;
        b=A3SUneLlLoRQaIVZftHbJqPlqqR2/CzOk/5nLPc8DJG649C1SnZ5EX+PDufbT5J96EoneN
        Bmzt8yC+FfoOg5pcMBY4ZkeoOcKtbNsPc2D9sQR/ECh5SuLS9nsyZ9Z6ph7kTBGtzF2e8m
        5X0cWn9m8D/b90Yf7Tx4CQVr6wgUuVc=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1659644673;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mX2pVowatUGhma8lkomeb+U7Bp7NNQJSP4qd6j4+tsw=;
        b=o7cYHRyqrIJamJ34l56r4zUh3BZ1DQbGjtz1KTcq16LTbV9MlY6vqQ3tWty5bgFYZsKFGi
        mXLNRD3F69qezuCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1D3FC13434;
        Thu,  4 Aug 2022 20:24:33 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ma69BQEr7GKLdgAAMHmgww
        (envelope-from <pvorel@suse.cz>); Thu, 04 Aug 2022 20:24:33 +0000
Date:   Thu, 4 Aug 2022 22:24:30 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Martin Doucha <mdoucha@suse.cz>
Cc:     ltp@lists.linux.it, linux-nfs@vger.kernel.org,
        Cyril Hrubis <chrubis@suse.cz>
Subject: Re: [PATCH 1/1] generate_lvm_runfile.sh: Fix bashism
Message-ID: <Yuwq/rrb6iWiRI9A@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20220803175752.19015-1-pvorel@suse.cz>
 <2fd92c3d-a67e-3cfc-aaf8-ca35176cf399@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2fd92c3d-a67e-3cfc-aaf8-ca35176cf399@suse.cz>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_SOFTFAIL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi Martin,

> Hi,
> `trap ... EXIT` cannot be used to emulate `trap ... ERR`. The latter
> behaves as if every command/pipeline in the script (except conditions)
> were wrapped in ROD. So `trap ... ERR` will trigger exit on any failure,
Ah, thx for info. OK, we also need to add set -e (or #!/bin/sh -e).
Because using ERR would require to change shebang to #!/bin/bash.

Kind regards,
Petr

> while `trap ... EXIT` will let the script continue after all errors and
> then check exit code of only the very last command. That's not what we
> want here.

> On 03. 08. 22 19:57, Petr Vorel wrote:
> > ERR is not on dash (tested on 0.5.11).

> > Signed-off-by: Petr Vorel <pvorel@suse.cz>
> > ---
> >  testcases/misc/lvm/generate_lvm_runfile.sh | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)

> > diff --git a/testcases/misc/lvm/generate_lvm_runfile.sh b/testcases/misc/lvm/generate_lvm_runfile.sh
> > index 72b286a69..5bf5d91d6 100755
> > --- a/testcases/misc/lvm/generate_lvm_runfile.sh
> > +++ b/testcases/misc/lvm/generate_lvm_runfile.sh
> > @@ -13,7 +13,7 @@ LVM_TMPDIR="$LVM_DIR/ltp/growfiles"

> >  generate_runfile()
> >  {
> > -	trap 'tst_brk TBROK "Cannot create LVM runfile"' ERR
> > +	trap '[ $? -eq 0 ] && exit 0 || tst_brk TBROK "Cannot create LVM runfile"' EXIT
> >  	INFILE="$LTPROOT/testcases/data/lvm/runfile.tpl"
> >  	OUTFILE="$LTPROOT/runtest/lvm.local"
> >  	FS_LIST=`tst_supported_fs`
