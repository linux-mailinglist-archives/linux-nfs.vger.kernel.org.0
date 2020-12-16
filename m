Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C34FF2DC225
	for <lists+linux-nfs@lfdr.de>; Wed, 16 Dec 2020 15:29:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbgLPO2o convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-nfs@lfdr.de>); Wed, 16 Dec 2020 09:28:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbgLPO2o (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 16 Dec 2020 09:28:44 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57127C061794
        for <linux-nfs@vger.kernel.org>; Wed, 16 Dec 2020 06:28:04 -0800 (PST)
Received: from dude.hi.pengutronix.de ([2001:67c:670:100:1d::7])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <u.oelmann@pengutronix.de>)
        id 1kpXmb-0002GZ-TU; Wed, 16 Dec 2020 15:28:01 +0100
Received: from uol by dude.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <u.oelmann@pengutronix.de>)
        id 1kpXmb-0006P2-FH; Wed, 16 Dec 2020 15:28:01 +0100
References: <20201209120643.14427-1-u.oelmann@pengutronix.de>
User-agent: mu4e 1.4.13; emacs 28.0.50
From:   Ulrich =?utf-8?Q?=C3=96lmann?= <u.oelmann@pengutronix.de>
To:     linux-nfs@vger.kernel.org
Cc:     Jeff Layton <jlayton@redhat.com>,
        Steve Dickson <steved@redhat.com>,
        Ulrich =?utf-8?Q?=C3=96lmann?= <u.oelmann@pengutronix.de>
Subject: Re: [PATCH nfs-utils] nfsd: clean up option parsing
In-reply-to: <20201209120643.14427-1-u.oelmann@pengutronix.de>
Date:   Wed, 16 Dec 2020 15:28:01 +0100
Message-ID: <6rbletbzbi.fsf@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::7
X-SA-Exim-Mail-From: u.oelmann@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-nfs@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Gentle ping!
(And putting Jeff & Steve on CC).

On Wed, Dec 09 2020 at 13:06 +0100, Ulrich Ölmann <u.oelmann@pengutronix.de> wrote:
> Presumably by mistake in commit [1] the unknown option 'i' slipped in together
> with a duplicated 't', so remove them from the optstring.
>
> [1] fbd7623dd8d5 ("nfsd: don't enable a UDP socket by default")
>
> Signed-off-by: Ulrich Ölmann <u.oelmann@pengutronix.de>
> ---
>  utils/nfsd/nfsd.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/utils/nfsd/nfsd.c b/utils/nfsd/nfsd.c
> index a412a026c6c5..c9f0385b5a00 100644
> --- a/utils/nfsd/nfsd.c
> +++ b/utils/nfsd/nfsd.c
> @@ -162,7 +162,7 @@ main(int argc, char **argv)
>  		}
>  	}
>  
> -	while ((c = getopt_long(argc, argv, "dH:hN:V:p:P:stTituUrG:L:", longopts, NULL)) != EOF) {
> +	while ((c = getopt_long(argc, argv, "dH:hN:V:p:P:stTuUrG:L:", longopts, NULL)) != EOF) {
>  		switch(c) {
>  		case 'd':
>  			xlog_config(D_ALL, 1);
-- 
Pengutronix e.K.                           | Ulrich Ölmann               |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
