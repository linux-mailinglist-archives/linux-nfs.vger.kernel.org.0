Return-Path: <linux-nfs+bounces-4745-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BA35092ABFC
	for <lists+linux-nfs@lfdr.de>; Tue,  9 Jul 2024 00:21:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 462C8B20A48
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jul 2024 22:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70BDA14F12C;
	Mon,  8 Jul 2024 22:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b="qjXs5elZ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21BF14B962;
	Mon,  8 Jul 2024 22:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.133.104.62
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720477274; cv=none; b=H+pftA2ZONQPzAXywszTSgwANBmfrqvrUhLaMs4D6e06hHxL7qm4U8N7fmR0iYDZ+PCYFrP2mvGE7Xy4tOX8nV7EugIKk75ZD8N46uAyN7zzr/jcd2qtcCGv8wF10lz/1NbtJItP4TRairwktjg2fKTTOh/Fp10Veet14rpyyxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720477274; c=relaxed/simple;
	bh=OP2rMW6ka7dHYVSZH9tDeQNRsRnlJpvEFOatETmLL9M=;
	h=Subject:To:Cc:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=HXJTHZHSJfSY4c2EiL9hKxmo6NDn4o1LIAZH/7AM0EDMf3Li1qCE+Azzn5N13qJ4gEiGwyy1xzqk4vvey/eQ7VrAyxjYWk/GhRpprYsrhkaals4Np48HO66WBa6KTHdJEsOKZAnpx6Mp4j0WqigqHFKMj79BqmUZa2ONn5obxmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net; spf=pass smtp.mailfrom=iogearbox.net; dkim=pass (2048-bit key) header.d=iogearbox.net header.i=@iogearbox.net header.b=qjXs5elZ; arc=none smtp.client-ip=213.133.104.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=iogearbox.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iogearbox.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=iogearbox.net; s=default2302; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID;
	bh=d5RbCV9jYwL2IZxVNe368PWZcHOxFg05uEyGMjh5L70=; b=qjXs5elZpbLdVMVRr3LmWShBRm
	fVtM9TXEaOlN9wbMKv9EWhPYjgSC4WV9wIpgHnuggpGfAqAJ+nYdX4wRdwgMEOK8u3DkvZ9P0CH5J
	SzZe/jZWGPTlBAMb3WuhDRCwbew/oEhxWr+tJ8qNPb5pz61opYue8ait41/xlQcFQQS4TGkyix0cI
	hQnBqk6kkpdVnUVVhmKsfzzdQc/Oe+uLUljqnRtaFLjqC756sDLHJd4XVM9eeU2/YtjzU2MlX+xMn
	CBd3bf9j4TmsRIAqppHZogUHGn4MIcs8b2tKErGALiElYQQOtqO+eUI/35+Tmn3U7NtDnz8uc5G3b
	/VEM7FXQ==;
Received: from sslproxy04.your-server.de ([78.46.152.42])
	by www62.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <daniel@iogearbox.net>)
	id 1sQwjN-0008nk-Nt; Tue, 09 Jul 2024 00:21:09 +0200
Received: from [178.197.248.35] (helo=linux.home)
	by sslproxy04.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <daniel@iogearbox.net>)
	id 1sQwjN-00053V-02;
	Tue, 09 Jul 2024 00:21:09 +0200
Subject: Re: [PATCH net v3 resend] net, sunrpc: Remap EPERM in case of
 connection failure in xs_tcp_setup_socket
To: kuba@kernel.org
Cc: netdev@vger.kernel.org, linux-nfs@vger.kernel.org,
 Lex Siegel <usiegl00@gmail.com>, Neil Brown <neilb@suse.de>,
 Trond Myklebust <trondmy@kernel.org>, Anna Schumaker <anna@kernel.org>
References: <9069ec1d59e4b2129fc23433349fd5580ad43921.1720075070.git.daniel@iogearbox.net>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <ce2ef435-7c59-01f1-c1bf-4405f44fd0f9@iogearbox.net>
Date: Tue, 9 Jul 2024 00:21:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <9069ec1d59e4b2129fc23433349fd5580ad43921.1720075070.git.daniel@iogearbox.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.10/27330/Mon Jul  8 10:36:43 2024)

On 7/4/24 8:41 AM, Daniel Borkmann wrote:
> When using a BPF program on kernel_connect(), the call can return -EPERM. This
> causes xs_tcp_setup_socket() to loop forever, filling up the syslog and causing
> the kernel to potentially freeze up.
> 
> Neil suggested:
> 
>    This will propagate -EPERM up into other layers which might not be ready
>    to handle it. It might be safer to map EPERM to an error we would be more
>    likely to expect from the network system - such as ECONNREFUSED or ENETDOWN.
> 
> ECONNREFUSED as error seems reasonable. For programs setting a different error
> can be out of reach (see handling in 4fbac77d2d09) in particular on kernels
> which do not have f10d05966196 ("bpf: Make BPF_PROG_RUN_ARRAY return -err
> instead of allow boolean"), thus given that it is better to simply remap for
> consistent behavior. UDP does handle EPERM in xs_udp_send_request().
> 
> Fixes: d74bad4e74ee ("bpf: Hooks for sys_connect")
> Fixes: 4fbac77d2d09 ("bpf: Hooks for sys_bind")
> Co-developed-by: Lex Siegel <usiegl00@gmail.com>
> Signed-off-by: Lex Siegel <usiegl00@gmail.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
> Cc: Neil Brown <neilb@suse.de>
> Cc: Trond Myklebust <trondmy@kernel.org>
> Cc: Anna Schumaker <anna@kernel.org>
> Link: https://github.com/cilium/cilium/issues/33395
> Link: https://lore.kernel.org/bpf/171374175513.12877.8993642908082014881@noble.neil.brown.name
> ---
>   [ Fixes tags are set to the orig connect commit so that stable team
>     can pick this up.
> 
>     Resend as it turns out that patchwork did not pick up the earlier
>     resends likely due to the message id being the same. ]
> 
>   v1 -> v2 -> v3:
>     - Plain resend, adding correct sunrpc folks to Cc
>       https://lore.kernel.org/bpf/Zn7wtStV+iafWRXj@tissot.1015granger.net/

(gentle ping)

