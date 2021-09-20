Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CEB641182E
	for <lists+linux-nfs@lfdr.de>; Mon, 20 Sep 2021 17:30:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236807AbhITPb3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 20 Sep 2021 11:31:29 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:46158 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234117AbhITPb3 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 20 Sep 2021 11:31:29 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 684B72201E;
        Mon, 20 Sep 2021 15:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1632151801;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q7Tr7ixug/f6CAucX4e9I4JZW6IgA6gAGqbB6ARKCg8=;
        b=Z8qUJtANdD0vqAB++YoQ86IDw77Cz/xWRihBZsUrEhRsRHbRW9+EL12ZkoetS4VdRvtxql
        CC/cT///uOQDs/6RrXx3BceUB4/tfH+wcK5HtvGdwU/Ugjn6toM8dZMFMC0C8h5XOxO2Fg
        sRn1cdr9xWe+J2vn+VWZuuRG9HM1lcs=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1632151801;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q7Tr7ixug/f6CAucX4e9I4JZW6IgA6gAGqbB6ARKCg8=;
        b=IXgqXssa57t0fm4kdtNCctV3Jt7VwcD02r7pqTtWf+TjZuN6ih/eYXlyw6JSMOpg275TnR
        xAqHbS14MivIn3BA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3C00013AED;
        Mon, 20 Sep 2021 15:30:01 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id Y3K7DPmoSGEYJQAAMHmgww
        (envelope-from <pvorel@suse.cz>); Mon, 20 Sep 2021 15:30:01 +0000
Date:   Mon, 20 Sep 2021 17:29:59 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     linux-nfs@vger.kernel.org
Cc:     Steve Dickson <steved@redhat.com>,
        Jianhong Yin <yin-jianhong@163.com>
Subject: Re: [PATCH 1/1] install-dep: Use command -v instead of which
Message-ID: <YUio94HQQKTaDdFi@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20210920152505.9423-1-pvorel@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210920152505.9423-1-pvorel@suse.cz>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> `command -v' is shell builtin required by POSIX [1] and supported on all
> common shells (bash, zsh, dash, busybox sh, mksh). `which' utility is not
> presented on some containers (e.g. Fedora, openSUSE), also going to be
> removed from future Debian versions.

> Also remove stderr redirection to /dev/null as it's unnecessary when
> using 'command': POSIX says "no output shall be written" if the command
> isn't found.
nit: [2] missing at the end of this paragraph.

Kind regards,
Petr

> [1] https://pubs.opengroup.org/onlinepubs/9699919799/utilities/command.html
> [2] https://salsa.debian.org/debian/debianutils/-/commit/3a8dd10b4502f7bae8fc6973c13ce23fc9da7efb

> Signed-off-by: Petr Vorel <pvorel@suse.cz>
> ---
>  install-dep | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

> diff --git a/install-dep b/install-dep
> index 621618fe..4698d44a 100755
> --- a/install-dep
> +++ b/install-dep
> @@ -2,20 +2,20 @@
>  #install dependencies for compiling from source code

>  #RHEL/Fedora/CentOS-Stream/Rocky
> -which dnf &>/dev/null || which yum &>/dev/null && {
> +command -v dnf >/dev/null || command -v yum >/dev/null && {
>  	yum install -y automake libtool make gcc rpcgen libtirpc-devel libevent-devel sqlite-devel device-mapper-devel \
>  		libblkid-devel krb5-devel libuuid-devel
>  }

>  #Debian/ubuntu
> -which apt &>/dev/null && {
> +command -v apt >/dev/null && {
>  	apt install -o APT::Install-Suggests=0 -o APT::Install-Recommends=0 --ignore-missing -y \
>  		autotools-dev automake make libtool pkg-config libtirpc-dev libevent-dev libsqlite3-dev \
>  		libdevmapper-dev libblkid-dev libkrb5-dev libkeyutils-dev uuid-dev
>  }

>  #openSUSE Leap
> -which zypper &>/dev/null && {
> +command -v zypper >/dev/null && {
>  	zypper in --no-recommends -y automake libtool make gcc rpcgen libtirpc-devel libevent-devel sqlite-devel \
>  		device-mapper-devel libblkid-devel krb5-devel libuuid-devel
>  }
