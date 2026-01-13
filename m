Return-Path: <linux-nfs+bounces-17791-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D2CD18B1D
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Jan 2026 13:26:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 120D63008173
	for <lists+linux-nfs@lfdr.de>; Tue, 13 Jan 2026 12:26:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16672389DE6;
	Tue, 13 Jan 2026 12:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="atYbskBj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gG60ynGb";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="atYbskBj";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="gG60ynGb"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786DF38E10A
	for <linux-nfs@vger.kernel.org>; Tue, 13 Jan 2026 12:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768307162; cv=none; b=b54EW3WKw80NewXNhvxCoXwYoNuOZkdBcCX7lE3djKRUuDQGG6qP/NmcM9Gxc/Vg0vyoSjvIT+lht5zVixip2VfwMo/J7b0R1ptRySzkuTNtFnKohVyz1jG9lSJ7BkzVzhCLDQr5aji19JOk+/w+zA+XoPp0TVV0DwE9v6I+xhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768307162; c=relaxed/simple;
	bh=g/rjwdnOQscPfcNZT17e/Vgb/YyREv7M4Js2pkPxyO8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J614zJPTswR03b6TdAI1x+zPSEtnc55GQ6JenrdARv1+5YkBUhDHQHQKxMri6b66BuRa+8r8Go0pbTkvWvI2111EOiqosRB4EfksSWUIbiwhG7eq+sX2jAwJNPe2y+L8jhx+am2KD96HfPyYPqlLuITRbzh9zgpYW9PZXbUGQwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz; spf=pass smtp.mailfrom=suse.cz; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=atYbskBj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gG60ynGb; dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b=atYbskBj; dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b=gG60ynGb; arc=none smtp.client-ip=195.135.223.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id CC2775BCDC;
	Tue, 13 Jan 2026 12:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768307158;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x4jrJ8I6fPIwLXaz5xhq8YI/1sMHR3N4D2S6Y0Ub0Sk=;
	b=atYbskBjS+5l5qoVM6y0u5gX6pTfKfX/FUwkEJJTk1kWNoAi0tP9t+z1MeosZMcx8XEEEX
	vAOQWoPm/8Qv7Pn5cLar+qv8OVl7yjCfI9sm9Lk3XSx9WBdtzAwKcRSnpetBaWCFe/FWQZ
	Q0NZDG66SAAwiKtEsDnwpPGUIYPUP0s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768307158;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x4jrJ8I6fPIwLXaz5xhq8YI/1sMHR3N4D2S6Y0Ub0Sk=;
	b=gG60ynGbClUXLgH1BABye51j6pk9oUzdUBOBK37hCUg4bIWdvSjysqjl+u4mAGAT4Iru6H
	cqFc90LBYlLaPBCw==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1768307158;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x4jrJ8I6fPIwLXaz5xhq8YI/1sMHR3N4D2S6Y0Ub0Sk=;
	b=atYbskBjS+5l5qoVM6y0u5gX6pTfKfX/FUwkEJJTk1kWNoAi0tP9t+z1MeosZMcx8XEEEX
	vAOQWoPm/8Qv7Pn5cLar+qv8OVl7yjCfI9sm9Lk3XSx9WBdtzAwKcRSnpetBaWCFe/FWQZ
	Q0NZDG66SAAwiKtEsDnwpPGUIYPUP0s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1768307158;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x4jrJ8I6fPIwLXaz5xhq8YI/1sMHR3N4D2S6Y0Ub0Sk=;
	b=gG60ynGbClUXLgH1BABye51j6pk9oUzdUBOBK37hCUg4bIWdvSjysqjl+u4mAGAT4Iru6H
	cqFc90LBYlLaPBCw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id A8E903EA63;
	Tue, 13 Jan 2026 12:25:58 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id UA5lKNY5ZmliUgAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Tue, 13 Jan 2026 12:25:58 +0000
Date: Tue, 13 Jan 2026 13:25:57 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Liu Jian <liujian56@huawei.com>
Cc: ltp@lists.linux.it, andrea.cervesato@suse.com,
	linux-nfs@vger.kernel.org, Steve Dickson <SteveD@redhat.com>
Subject: Re: [LTP] [PATCH v2] rpc: create valid fd to pass libtirpc validation
Message-ID: <20260113122557.GA318506@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20260112015047.2184003-1-liujian56@huawei.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260112015047.2184003-1-liujian56@huawei.com>
X-Spam-Score: -3.50
X-Spamd-Result: default: False [-3.50 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_RHS_NOT_FQDN(0.50)[];
	HAS_REPLYTO(0.30)[pvorel@suse.cz];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	URIBL_BLOCKED(0.00)[huawei.com:email];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[imap1.dmz-prg2.suse.org:helo,suse.cz:replyto];
	RCPT_COUNT_FIVE(0.00)[5];
	REPLYTO_EQ_FROM(0.00)[]
X-Spam-Level: 
X-Spam-Flag: NO

Hi all,

[ Cc Steve and linux-nfs ]

> The testcase(rpc_svc_destroy, rpc_svcfd_create, rpc_xprt_register,
> rpc_xprt_unregister) was failing due to an invalid fd, which
> caused libtirpc's internal validation to reject the operation.
> This change ensures a valid socket fd is created and can pass the
> validation checks in libtirpc.

+ I would also like to know more details about the failure (libtirpc version, or
do you still use Sun RPC from old glibc, distro, arch, ...).

Because while we have some problems with some of these tests, I'm not sure if
connecting to 127.0.0.1 is a valid approach. And if it is, should it be used in
more tests? Also rpc_svc_destroy_stress.c and rpc_svcfd_create_limits.c use
svcfd_create().

Below are few minor implementation details. First, maybe add a common header,
with code in the function which would be used? But it can be done later (RPC
test code is really awful, more duplicity will not make it worse).

> Signed-off-by: Liu Jian <liujian56@huawei.com>
> ---
> v2: Fix a compilation error on Alpine.
>  .../rpc_svc_destroy.c                         | 27 +++++++++++++++++++
>  .../rpc_svcfd_create.c                        | 26 ++++++++++++++++++
>  .../rpc_xprt_register.c                       | 25 +++++++++++++++++
>  .../rpc_xprt_unregister.c                     | 25 +++++++++++++++++
>  4 files changed, 103 insertions(+)

> diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svc_destroy/rpc_svc_destroy.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svc_destroy/rpc_svc_destroy.c
> index 22e560843..b9240ccba 100644
> --- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svc_destroy/rpc_svc_destroy.c
> +++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svc_destroy/rpc_svc_destroy.c
> @@ -30,6 +30,12 @@
>  #include <time.h>
>  #include <rpc/rpc.h>

> +#include <unistd.h>
> +#include <sys/socket.h>
> +#include <netinet/in.h>
> +#include <arpa/inet.h>
> +#include <string.h>
> +
>  //Standard define
>  #define PROCNUM 1
>  #define VERSNUM 1
> @@ -43,6 +49,27 @@ int main(void)
>  	int test_status = 1;	//Default test result set to FAILED
>  	int fd = 0;
>  	SVCXPRT *svcr = NULL;
> +	struct sockaddr_in server_addr;
> +
> +	fd = socket(AF_INET, SOCK_DGRAM, 0);
> +	if (fd < 0) {
> +		printf("socket creation failed");
Maybe fprintf(stderr, ...) or perror()?

> +		return test_status;
> +	}
> +
> +	memset(&server_addr, 0, sizeof(server_addr));

Maybe just:
struct sockaddr_in server_addr = {0};
instead of memset() ?

> +	server_addr.sin_family = AF_INET;
> +	server_addr.sin_port = htons(9001);
> +	if (inet_pton(AF_INET, "127.0.0.1", &server_addr.sin_addr) <= 0) {
> +		printf("inet_pton failed");
> +		close(fd);
> +		return test_status;
> +	}
> +	if (connect(fd, (struct sockaddr *)&server_addr, sizeof(server_addr)) < 0) {
> +		printf("connect failed");
> +		close(fd);
Funny that all testsuites don't close fd, but not closing single fd is not that
problematic.

Kind regards,
Petr

> +		return test_status;
> +	}

>  	//First of all, create a server
>  	svcr = svcfd_create(fd, 0, 0);
> diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcfd_create/rpc_svcfd_create.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcfd_create/rpc_svcfd_create.c
> index f0d89ba48..ea4418961 100644
> --- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcfd_create/rpc_svcfd_create.c
> +++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_createdestroy_svcfd_create/rpc_svcfd_create.c
> @@ -29,6 +29,11 @@
>  #include <stdlib.h>
>  #include <time.h>
>  #include <rpc/rpc.h>
> +#include <unistd.h>
> +#include <sys/socket.h>
> +#include <netinet/in.h>
> +#include <arpa/inet.h>
> +#include <string.h>

>  //Standard define
>  #define PROCNUM 1
> @@ -43,6 +48,27 @@ int main(void)
>  	int test_status = 1;	//Default test result set to FAILED
>  	int fd = 0;
>  	SVCXPRT *svcr = NULL;
> +	struct sockaddr_in server_addr;
> +
> +	fd = socket(AF_INET, SOCK_DGRAM, 0);
> +	if (fd < 0) {
> +		printf("socket creation failed");
> +		return test_status;
> +	}
> +
> +	memset(&server_addr, 0, sizeof(server_addr));
> +	server_addr.sin_family = AF_INET;
> +	server_addr.sin_port = htons(9001);
> +	if (inet_pton(AF_INET, "127.0.0.1", &server_addr.sin_addr) <= 0) {
> +		printf("inet_pton failed");
> +		close(fd);
> +		return test_status;
> +	}
> +	if (connect(fd, (struct sockaddr *)&server_addr, sizeof(server_addr)) < 0) {
> +		printf("connect failed");
> +		close(fd);
> +		return test_status;
> +	}

>  	//create a server
>  	svcr = svcfd_create(fd, 0, 0);
> diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_register/rpc_xprt_register.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_register/rpc_xprt_register.c
> index b10a1ce5e..a40dad7fe 100644
> --- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_register/rpc_xprt_register.c
> +++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_register/rpc_xprt_register.c
> @@ -31,6 +31,10 @@
>  #include <rpc/rpc.h>
>  #include <sys/types.h>
>  #include <sys/socket.h>
> +#include <unistd.h>
> +#include <netinet/in.h>
> +#include <arpa/inet.h>
> +#include <string.h>

>  //Standard define
>  #define PROCNUM 1
> @@ -45,6 +49,27 @@ int main(void)
>  	int test_status = 1;	//Default test result set to FAILED
>  	SVCXPRT *svcr = NULL;
>  	int fd = 0;
> +	struct sockaddr_in server_addr;
> +
> +	fd = socket(AF_INET, SOCK_DGRAM, 0);
> +	if (fd < 0) {
> +		printf("socket creation failed");
> +		return test_status;
> +	}
> +
> +	memset(&server_addr, 0, sizeof(server_addr));
> +	server_addr.sin_family = AF_INET;
> +	server_addr.sin_port = htons(9001);
> +	if (inet_pton(AF_INET, "127.0.0.1", &server_addr.sin_addr) <= 0) {
> +		printf("inet_pton failed");
> +		close(fd);
> +		return test_status;
> +	}
> +	if (connect(fd, (struct sockaddr *)&server_addr, sizeof(server_addr)) < 0) {
> +		printf("connect failed");
> +		close(fd);
> +		return test_status;
> +	}

>  	//create a server
>  	svcr = svcfd_create(fd, 1024, 1024);
> diff --git a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_unregister/rpc_xprt_unregister.c b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_unregister/rpc_xprt_unregister.c
> index 3b6130eaa..5ac51de41 100644
> --- a/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_unregister/rpc_xprt_unregister.c
> +++ b/testcases/network/rpc/rpc-tirpc/tests_pack/rpc_suite/rpc/rpc_regunreg_xprt_unregister/rpc_xprt_unregister.c
> @@ -31,6 +31,10 @@
>  #include <rpc/rpc.h>
>  #include <sys/types.h>
>  #include <sys/socket.h>
> +#include <unistd.h>
> +#include <netinet/in.h>
> +#include <arpa/inet.h>
> +#include <string.h>

>  //Standard define
>  #define PROCNUM 1
> @@ -49,6 +53,27 @@ int main(int argn, char *argc[])
>  	int test_status = 1;	//Default test result set to FAILED
>  	SVCXPRT *svcr = NULL;
>  	int fd = 0;
> +	struct sockaddr_in server_addr;
> +
> +	fd = socket(AF_INET, SOCK_DGRAM, 0);
> +	if (fd < 0) {
> +		printf("socket creation failed");
> +		return test_status;
> +	}
> +
> +	memset(&server_addr, 0, sizeof(server_addr));
> +	server_addr.sin_family = AF_INET;
> +	server_addr.sin_port = htons(9001);
> +	if (inet_pton(AF_INET, "127.0.0.1", &server_addr.sin_addr) <= 0) {
> +		printf("inet_pton failed");
> +		close(fd);
> +		return test_status;
> +	}
> +	if (connect(fd, (struct sockaddr *)&server_addr, sizeof(server_addr)) < 0) {
> +		printf("connect failed");
> +		close(fd);
> +		return test_status;
> +	}

>  	//create a server
>  	svcr = svcfd_create(fd, 1024, 1024);

