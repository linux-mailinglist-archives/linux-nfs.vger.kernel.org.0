Return-Path: <linux-nfs+bounces-21414-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8OWTIpSl+2kNewMAu9opvQ
	(envelope-from <linux-nfs+bounces-21414-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Wed, 06 May 2026 22:33:24 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 050994E038E
	for <lists+linux-nfs@lfdr.de>; Wed, 06 May 2026 22:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EE88F300D169
	for <lists+linux-nfs@lfdr.de>; Wed,  6 May 2026 20:33:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14D093AE1BD;
	Wed,  6 May 2026 20:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ASVziIHv";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="CVFQnb3X"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E983AE189
	for <linux-nfs@vger.kernel.org>; Wed,  6 May 2026 20:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778099600; cv=none; b=NEwsOnyGznpIl/Lw7L1W7EVC8TIN5C1aNsZsQgnCGaMCCqaJhi262/e7On1ySLH3BZVAevAPoywbgc9UWagu8YiUAAA7CD/uhJKjHNGt8sXpR6zeuhf2CZhgRhsuzMRzLzvTqXoCl4K5iiwl67Rq7na2PjVYxCmpoCsX7XZ/POU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778099600; c=relaxed/simple;
	bh=6OqF+ADZszN4IRJr0zshYHMPTtkoXz1hc20ohgON8wc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SMOqG7snhOXyv0HTqlNSw/W0vJtKgxtxO3O7vKF0JCc+T7efsGNu9iw2JB66dJp/UV2lwa6EKSspGTvvIEtfJrfY0kz2rtPUQQ9OaYMQA2PJLMrzom30gKYIA2OP+BtB+Bfh3IdlvMg/uNMqtEcegZK1GIQEz322BWk1epwXMEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ASVziIHv; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=CVFQnb3X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778099597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2dh3j4ELXuzx03U2WiC8Jal5eJve47Llz/p1XTMG7vA=;
	b=ASVziIHvH5NknLRs/7oVNb72y4bfWoizpP9HDNveAEKjeUIj5PLxh9h2RXHxMkswg8HZXr
	frIFDwJIOXggVBqurfrThpoFg0g13pqLDY55lkMA+hHo4y9ihYvnU/2kjAWQq0MXfy75it
	DXs2zLeiW4NP76PvvkGu1cKv1iZMH2s=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-199-9EJ7zBZXMkyrAgE5cpQXjQ-1; Wed, 06 May 2026 16:33:16 -0400
X-MC-Unique: 9EJ7zBZXMkyrAgE5cpQXjQ-1
X-Mimecast-MFC-AGG-ID: 9EJ7zBZXMkyrAgE5cpQXjQ_1778099595
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-50e67a4f642so1497991cf.0
        for <linux-nfs@vger.kernel.org>; Wed, 06 May 2026 13:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1778099594; x=1778704394; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2dh3j4ELXuzx03U2WiC8Jal5eJve47Llz/p1XTMG7vA=;
        b=CVFQnb3XnIBPMUCryBEFUO0niuJyfSpU6oKoRun1AlVyoBZYYbQpfMiy+sqaOeZ30u
         l3atuZgc63A0abpI1z2kjCbeiQY8+uneG2zvrtgzusP0LYld4mDjYbHF89vgVQ7++o0X
         6HeGRYYgV/z+kroG8DgTzOvG9lVEixLFhK3dhq+/G5n3+M9mYupOyz8tLv8r+KMyvq2y
         8GPFpXIDUmlYKWuxLXgJyeCHXyJ4J0tAHEPpq7r9DFS5AOWsDDFUAxgypBomI6osr053
         GcXqoWnZ/p82wuLboPiFB4cft9EmwG2ofQchzwwPIsKG9pBN7g+CkEzQV1tpCrUD1uDr
         beOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778099594; x=1778704394;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2dh3j4ELXuzx03U2WiC8Jal5eJve47Llz/p1XTMG7vA=;
        b=J46ShuE1kjtMYsoWR150mTGEPpBUuMXDzVIMJw2wI1l3wYn22FiU7+YMvV4Je2ieuG
         27D30jvwreOjS9BeUSawYoPxdjckZ932l+jaV+WVtge0KAOd5Norx9IazKeNsIeFGPFt
         ywO9RHjZdQ6ze2B8JP90sdqgT6UqxIYFejXeINLSkwvQEfKst18AHKzw8qsHeQUPGs5D
         akGN37Hqy5mlQke0oPnj/yChfbvoXrlPAXgRV20oYje8sRl6Fbv7H4+cYIij8p7bRSGp
         g98N5Xd5eSikPDMPJoolQBuJ6K/kr7eRXrgPthuHRkLK6CxcEIMMm8BbAkTJ9BDR4k/O
         Ig1A==
X-Gm-Message-State: AOJu0Yw4fiemA/jkWy+u6waKAWWD0rx58Qz4JlSGrM5S7Ib7xftcCYFe
	NGyaiVcBKoaljKV35Qg0xzT2MsKB6u0ZqhenuPohvYz5ZAgQRKTG8wqAVwfqzr/WFoAv5xvE9BJ
	oL63c2Onnx8dYpTf5GCi7LqGCGr3Um3u6rcbbaL9DAyFPJbdlBl1NceskNvP19ljaVbarOg==
X-Gm-Gg: AeBDies8Dlv8AUSduFqJjvxBXPyCjGgnAg0B9Bf5neNU+JMRpj1CIwLrbClO5pQtZK8
	p3GtEGZura9KQ2AiW+02xx6uJL0LdmnDShYq6cNmJXFdHhneCynr/bZWJulWtDjb+vFmaEaR8zU
	fg5KuHyqbUe9oiGIs2L6YA880UV1w9Bw5Sx5/ZMgvfNDRZyWf9F90yDTy0oIVv4zyTul/60XbpP
	U0fJmJnmizaAKQ9lVCqXigfri0alD8HtJu3Id1533N8DbRCeqT8Stw2htEZ41+LhWXN/IgWevnH
	YHP+O8gjHiaacqh7g9Av/UYQoyMZFKu6xYsSvJbqgt6HPBIcsc5wK6jJwWmcuprvjIcL6XmC+wG
	GoGo1vVE1yib+oor6yEskUOgZU1vwm/2w
X-Received: by 2002:ac8:5e4e:0:b0:50f:af1b:1dec with SMTP id d75a77b69052e-51461fbc4d5mr68253641cf.40.1778099594463;
        Wed, 06 May 2026 13:33:14 -0700 (PDT)
X-Received: by 2002:ac8:5e4e:0:b0:50f:af1b:1dec with SMTP id d75a77b69052e-51461fbc4d5mr68253181cf.40.1778099593903;
        Wed, 06 May 2026 13:33:13 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.250.214])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8b538b1da71sm202535586d6.7.2026.05.06.13.33.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 May 2026 13:33:13 -0700 (PDT)
Message-ID: <32b6dcdc-c7af-4e2e-8639-06e590f82599@redhat.com>
Date: Wed, 6 May 2026 16:33:12 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] nfs-utils: add option to display throughput in MB/s
To: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
Cc: linux-nfs@vger.kernel.org
References: <20260501205604.653238-1-tigran.mkrtchyan@desy.de>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20260501205604.653238-1-tigran.mkrtchyan@desy.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 050994E038E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-21414-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWO(0.00)[2];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-nfs];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]



On 5/1/26 4:56 PM, Tigran Mkrtchyan wrote:
> Nowadays,the network bandwidth in kB/s is quite a large number to read.
> Thus, let nfsiostat display it in MB/s if requested.
> 
> Signed-off-by: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
Committed... (tag: nfs-utils-2-9-2-rc2)

steved.

> ---
>   tools/nfs-iostat/nfs-iostat.py | 53 ++++++++++++++++++++++------------
>   tools/nfs-iostat/nfsiostat.man | 11 ++++---
>   2 files changed, 42 insertions(+), 22 deletions(-)
> 
> diff --git a/tools/nfs-iostat/nfs-iostat.py b/tools/nfs-iostat/nfs-iostat.py
> index 69d24a11..af04aac5 100755
> --- a/tools/nfs-iostat/nfs-iostat.py
> +++ b/tools/nfs-iostat/nfs-iostat.py
> @@ -327,7 +327,7 @@ class DeviceData:
>               print()
>               print('%d congestion waits' % congestionwaits)
>   
> -    def __print_rpc_op_stats(self, op, sample_time):
> +    def __print_rpc_op_stats(self, op, sample_time, use_mb=False):
>           """Print generic stats for one RPC op
>           """
>           if op not in self.__rpc_data:
> @@ -343,9 +343,19 @@ class DeviceData:
>           if len(rpc_stats) >= 9:
>               errs = float(rpc_stats[8])
>   
> +        # scale to MB if requested
> +        if use_mb:
> +            throughput = kilobytes / 1024.0
> +            throughput_label = 'MB/s'
> +            per_op_label = 'MB/op'
> +        else:
> +            throughput = kilobytes
> +            throughput_label = 'kB/s'
> +            per_op_label = 'kB/op'
> +
>           # prevent floating point exceptions
>           if ops != 0:
> -            kb_per_op = kilobytes / ops
> +            unit_per_op = throughput / ops
>               retrans_percent = (retrans * 100) / ops
>               rtt_per_op = rtt / ops
>               exe_per_op = exe / ops
> @@ -353,7 +363,7 @@ class DeviceData:
>               if len(rpc_stats) >= 9:
>                   errs_percent = (errs * 100) / ops
>           else:
> -            kb_per_op = 0.0
> +            unit_per_op = 0.0
>               retrans_percent = 0.0
>               rtt_per_op = 0.0
>               exe_per_op = 0.0
> @@ -364,8 +374,8 @@ class DeviceData:
>           op += ':'
>           print(format(op.lower(), '<16s'), end='')
>           print(format('ops/s', '>8s'), end='')
> -        print(format('kB/s', '>16s'), end='')
> -        print(format('kB/op', '>16s'), end='')
> +        print(format(throughput_label, '>16s'), end='')
> +        print(format(per_op_label, '>16s'), end='')
>           print(format('retrans', '>16s'), end='')
>           print(format('avg RTT (ms)', '>16s'), end='')
>           print(format('avg exe (ms)', '>16s'), end='')
> @@ -375,8 +385,8 @@ class DeviceData:
>           print()
>   
>           print(format((ops / sample_time), '>24.3f'), end='')
> -        print(format((kilobytes / sample_time), '>16.3f'), end='')
> -        print(format(kb_per_op, '>16.3f'), end='')
> +        print(format((throughput / sample_time), '>16.3f'), end='')
> +        print(format(unit_per_op, '>16.3f'), end='')
>           retransmits = '{0:>10.0f} ({1:>3.1f}%)'.format(retrans, retrans_percent).strip()
>           print(format(retransmits, '>16'), end='')
>           print(format(rtt_per_op, '>16.3f'), end='')
> @@ -395,9 +405,11 @@ class DeviceData:
>               sample_time = 1;
>           return (sends / sample_time)
>   
> -    def display_iostats(self, sample_time, which):
> +    def display_iostats(self, sample_time, options):
>           """Display NFS and RPC stats in an iostat-like way
>           """
> +        which = options.which
> +        use_mb = options.megabytes
>           sends = float(self.__rpc_data['rpcsends'])
>           if sample_time == 0:
>               sample_time = float(self.__nfs_data['age'])
> @@ -423,21 +435,21 @@ class DeviceData:
>           print()
>   
>           if which == 0:
> -            self.__print_rpc_op_stats('READ', sample_time)
> -            self.__print_rpc_op_stats('WRITE', sample_time)
> +            self.__print_rpc_op_stats('READ', sample_time, use_mb)
> +            self.__print_rpc_op_stats('WRITE', sample_time, use_mb)
>           elif which == 1:
> -            self.__print_rpc_op_stats('GETATTR', sample_time)
> -            self.__print_rpc_op_stats('ACCESS', sample_time)
> +            self.__print_rpc_op_stats('GETATTR', sample_time, use_mb)
> +            self.__print_rpc_op_stats('ACCESS', sample_time, use_mb)
>               self.__print_attr_cache_stats(sample_time)
>           elif which == 2:
> -            self.__print_rpc_op_stats('LOOKUP', sample_time)
> -            self.__print_rpc_op_stats('READDIR', sample_time)
> +            self.__print_rpc_op_stats('LOOKUP', sample_time, use_mb)
> +            self.__print_rpc_op_stats('READDIR', sample_time, use_mb)
>               if 'READDIRPLUS' in self.__rpc_data:
> -                self.__print_rpc_op_stats('READDIRPLUS', sample_time)
> +                self.__print_rpc_op_stats('READDIRPLUS', sample_time, use_mb)
>               self.__print_dir_cache_stats(sample_time)
>           elif which == 3:
> -            self.__print_rpc_op_stats('READ', sample_time)
> -            self.__print_rpc_op_stats('WRITE', sample_time)
> +            self.__print_rpc_op_stats('READ', sample_time, use_mb)
> +            self.__print_rpc_op_stats('WRITE', sample_time, use_mb)
>               self.__print_page_stats(sample_time)
>   
>           sys.stdout.flush()
> @@ -500,7 +512,7 @@ def print_iostat_summary(old, new, devices, time, options):
>   
>       count = 1
>       for device in devices:
> -        display_stats[device].display_iostats(time, options.which)
> +        display_stats[device].display_iostats(time, options)
>   
>           count += 1
>           if (count > options.list):
> @@ -585,6 +597,11 @@ client are listed.
>                               type="int",
>                               dest="list",
>                               help="only print stats for first LIST mount points")
> +    displaygroup.add_option('-m', '--megabytes',
> +                            action="store_true",
> +                            dest="megabytes",
> +                            default=False,
> +                            help="display throughput in megabytes per second (MB/s) instead of kilobytes per second (kB/s)")
>       parser.add_option_group(displaygroup)
>   
>       (options, args) = parser.parse_args(sys.argv)
> diff --git a/tools/nfs-iostat/nfsiostat.man b/tools/nfs-iostat/nfsiostat.man
> index 104c7ab4..4f24318d 100644
> --- a/tools/nfs-iostat/nfsiostat.man
> +++ b/tools/nfs-iostat/nfsiostat.man
> @@ -56,16 +56,16 @@ This is the length of the backlog queue.
>   .RE
>   .RE
>   .RS 8
> -- \fBkB/s\fR
> +- \fBkB/s (MB/s)\fR
>   .RS
> -This is the number of kB written/read per second.
> +This is the number of kB (or MB) written/read per second.
>   .RE
>   .RE
>   .RE
>   .RS 8
> -- \fBkB/op\fR
> +- \fBkB/op (MB/op)\fR
>   .RS
> -This is the number of kB written/read per each operation.
> +This is the number of kB (or MB) written/read per each operation.
>   .RE
>   .RE
>   .RE
> @@ -122,6 +122,9 @@ shows help message and exit
>   .B \-l LIST or " \-\-list=LIST
>   only print stats for first LIST mount points
>   .TP
> +.B \-m or " \-\-megabytes
> +display throughput in megabytes per second
> +.TP
>   .B \-p " or " \-\-page
>   displays statistics related to the page cache
>   .TP


