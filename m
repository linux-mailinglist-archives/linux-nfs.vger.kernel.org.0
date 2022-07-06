Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF21A5684D0
	for <lists+linux-nfs@lfdr.de>; Wed,  6 Jul 2022 12:11:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232684AbiGFKLX (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 6 Jul 2022 06:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232882AbiGFKLN (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 6 Jul 2022 06:11:13 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 702B93A5
        for <linux-nfs@vger.kernel.org>; Wed,  6 Jul 2022 03:11:07 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <bst@pengutronix.de>)
        id 1o91zt-00057r-35; Wed, 06 Jul 2022 12:11:05 +0200
Message-ID: <82f7edc0-c9d4-6a9a-1360-1b6e5b2f1d59@pengutronix.de>
Date:   Wed, 6 Jul 2022 12:11:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH rpcbind] autotools/systemd: call rpcbind with -w only on
 enabled warm starts
Content-Language: en-US
To:     linux-nfs@vger.kernel.org
Cc:     Steve Dickson <steved@redhat.com>, kernel@pengutronix.de
References: <20210611122803.24747-1-bst@pengutronix.de>
From:   Bastian Krause <bst@pengutronix.de>
In-Reply-To: <20210611122803.24747-1-bst@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: bst@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-nfs@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 6/11/21 14:28, Bastian Krause wrote:
> If rpcbind is configured with --disable-warmstarts it responds on -w
> with its usage string. This is not helpful in a systemd service, so pass
> -w conditionally.
> 
> Signed-off-by: Bastian Krause <bst@pengutronix.de>

Gentle ping!

Regards,
Bastian

> ---
>   configure.ac               | 6 ++++++
>   systemd/rpcbind.service.in | 2 +-
>   2 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/configure.ac b/configure.ac
> index c0ef896..c2069a2 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -20,6 +20,12 @@ AM_CONDITIONAL(LIBSETDEBUG, test x$lib_setdebug = xyes)
>   AC_ARG_ENABLE([warmstarts],
>     AS_HELP_STRING([--enable-warmstarts], [Enables Warm Starts @<:@default=no@:>@]))
>   AM_CONDITIONAL(WARMSTART, test x$enable_warmstarts = xyes)
> +AS_IF([test x$enable_warmstarts = xyes], [
> +	warmstarts_opt=-w
> +], [
> +	warmstarts_opt=
> +])
> +AC_SUBST([warmstarts_opt], [$warmstarts_opt])
>   
>   AC_ARG_ENABLE([rmtcalls],
>     AS_HELP_STRING([--enable-rmtcalls], [Enables Remote Calls @<:@default=no@:>@]))
> diff --git a/systemd/rpcbind.service.in b/systemd/rpcbind.service.in
> index 7b1c74b..c892ca8 100644
> --- a/systemd/rpcbind.service.in
> +++ b/systemd/rpcbind.service.in
> @@ -12,7 +12,7 @@ Wants=rpcbind.target
>   [Service]
>   Type=notify
>   # distro can provide a drop-in adding EnvironmentFile=-/??? if needed.
> -ExecStart=@_sbindir@/rpcbind $RPCBIND_OPTIONS -w -f
> +ExecStart=@_sbindir@/rpcbind $RPCBIND_OPTIONS @warmstarts_opt@ -f
>   
>   [Install]
>   WantedBy=multi-user.target


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
