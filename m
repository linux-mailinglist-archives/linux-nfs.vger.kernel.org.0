Return-Path: <linux-nfs+bounces-18921-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QIZDLeXnjmkDFwEAu9opvQ
	(envelope-from <linux-nfs+bounces-18921-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Feb 2026 09:59:17 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 55DD51343FE
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Feb 2026 09:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B58B2301CC89
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Feb 2026 08:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB71E31283E;
	Fri, 13 Feb 2026 08:59:13 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A29E228505E;
	Fri, 13 Feb 2026 08:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770973153; cv=none; b=Nu/F7OL4I6Wy1qLdY74VZbxHEKKHSgKmyPhw4hHAWC/QJok3jm4b6vqQHKSF9mYIZ+Cvf/T5fNgxaWdWm1jezzoh2IDUugUW3p4Hbf4TSBtO2SZHBCuq50jTGoC8hJGIqV8g/w6esXIXQO7AQ9uDUIVqIO5+Fot2uNAhPM+nE9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770973153; c=relaxed/simple;
	bh=9Y33UT5RoCW9WM4dLti1NWmbgFKbrgPf9icuzC8TY7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WkP6Tq5JGilgV0DCcU6adf3R6WlnoQOPg1psqUtLMT1LKgmHcxq+0gdPh9CKeKIsETgZnZKbm+l6PIeJx2IQLiXOdH4CaJEQVJ9DPRsXxSBEfeCnBVOHWkcKmWsSaI1D5da+gFXSgF5NgBi44pL/YrmOKiN2DuUv+nb0ZmG3KFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C021C116C6;
	Fri, 13 Feb 2026 08:59:12 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: anna@kernel.org
Cc: trond.myklebust@hammerspace.com,
	linux-nfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re; [PATCH v2 14/14] NFS: Merge CONFIG_NFS_V4_1 with CONFIG_NFS_V4
Date: Fri, 13 Feb 2026 09:58:43 +0100
Message-ID: <20260213085843.664927-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260126203938.450304-15-anna@kernel.org>
References: <20260126203938.450304-15-anna@kernel.org>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-18921-lists,linux-nfs=lfdr.de,renesas];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_NA(0.00)[glider.be];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FROM_HAS_DN(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	R_DKIM_NA(0.00)[];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[geert@glider.be,linux-nfs@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux-m68k.org:email]
X-Rspamd-Queue-Id: 55DD51343FE
X-Rspamd-Action: no action

> Compiling the NFSv4 module without any minorversion support doesn't make
> much sense, so this patch sets NFS v4.1 as the default, always enabled
> NFS version allowing us to replace all the CONFIG_NFS_V4_1s scattered
> throughout the code with CONFIG_NFS_V4.
> 
> Signed-off-by: Anna Schumaker <anna.schumaker@oracle.com>

Thanks for your patch, which is now commit 7537db24806fdc3d ("NFS:
Merge CONFIG_NFS_V4_1 with CONFIG_NFS_V4") upstream.

> --- a/fs/nfs/Kconfig
> +++ b/fs/nfs/Kconfig
> @@ -78,9 +78,10 @@ config NFS_V4
>  	tristate "NFS client support for NFS version 4"
>  	depends on NFS_FS
>  	select KEYS
> +	select SUNRPC_BACKCHANNEL
>  	help
> -	  This option enables support for version 4 of the NFS protocol
> -	  (RFC 3530) in the kernel's NFS client.
> +	  This option enables support for version 4.1 of the NFS protocol
> +	  (RFC 5661) in the kernel's NFS client.
>  
>  	  To mount NFS servers using NFSv4, you also need to install user
>  	  space programs which can be found in the Linux nfs-utils package,

And out of context:

    If unsure, say Y.

Shouldn't that become "N", cfr. the old NFS_V4_1 below?

And shouldn't all configs currently enabling CONFIG_NFS_V4, but not
CONFIG_NFS_V4_1, be updated to disable CONFIG_NFS_V4?

> @@ -105,19 +106,9 @@ config NFS_V4_0
>  
>  	  If unsure, say N.
>  
> -config NFS_V4_1
> -	bool "NFS client support for NFSv4.1"
> -	depends on NFS_V4
> -	select SUNRPC_BACKCHANNEL
> -	help
> -	  This option enables support for minor version 1 of the NFSv4 protocol
> -	  (RFC 5661) in the kernel's NFS client.
> -
> -	  If unsure, say N.
> -
>  config NFS_V4_2
>  	bool "NFS client support for NFSv4.2"
> -	depends on NFS_V4_1
> +	depends on NFS_V4
>  	help
>  	  This option enables support for minor version 2 of the NFSv4 protocol
>  	  in the kernel's NFS client.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds

