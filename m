Return-Path: <linux-nfs+bounces-23254-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id g1pBFkBtUmq9PgMAu9opvQ
	(envelope-from <linux-nfs+bounces-23254-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Jul 2026 18:20:16 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43039742277
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Jul 2026 18:20:15 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=Mp7v9I81;
	dkim=pass header.d=redhat.com header.s=google header.b=gXvLQF1b;
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23254-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23254-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3A523300469C
	for <lists+linux-nfs@lfdr.de>; Sat, 11 Jul 2026 16:20:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C4A1286881;
	Sat, 11 Jul 2026 16:20:10 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5B181D7E41
	for <linux-nfs@vger.kernel.org>; Sat, 11 Jul 2026 16:20:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783786810; cv=none; b=O1/0D+bX52sXQtMY5de39W623w+cQRx1kc3P2PuDzztBv7IhlF2FEWIm/pMw0QS5LEDlVNNmM6b3j9vj/McJOSaXsbC3KR9QKE90zlHZQLkNSINpVV/5adPP8If5DGzLvbf+eoCgcLc+u3ZD5vhs6wLIHsMhi2n8pg+RtInYEYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783786810; c=relaxed/simple;
	bh=TQra0aAN9yzQWXgPsrP8ta/plHhTTS3+dfQ6k7y11VU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=o90gKBI1CGdaj1CdVk6RisdDSZKaSr03xBxAzEXxiMqCE/1ZwoKlwRqfxP6AvLbYzpEDY9HW9CMxxU4+BnX/LcFkFN2hs2dBiQwFVtbjrCicguHVx/4YuksXSArcoeGFMBQn020n7gnwAEHry3QSPe9a1TnA1UriKzA9Ufa3uiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Mp7v9I81; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gXvLQF1b; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1783786807;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jZhjoM3HRleZk2ni0rE/sV17HuAJS+Lc2ckX2y0WT8g=;
	b=Mp7v9I81LmSGQfmnnej9mq1KwQHZJjnPinQI0X//uzfVi69jvoM0ZMJ6Dpp+VtTvUUewdt
	Pfu/BsJz5bXmenw9cDcF0ajrBf320mT5gjGODJ0E7MLT4i+h/dd/xaxX6E4DDKME0Pdm3M
	Lj6Sn7yBYzkISMvFCFygLrJGmn+pA9M=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-J1tyhvIjMJm7wsTQn_xj6Q-1; Sat, 11 Jul 2026 12:20:06 -0400
X-MC-Unique: J1tyhvIjMJm7wsTQn_xj6Q-1
X-Mimecast-MFC-AGG-ID: J1tyhvIjMJm7wsTQn_xj6Q_1783786806
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c1e6f602cso34640851cf.3
        for <linux-nfs@vger.kernel.org>; Sat, 11 Jul 2026 09:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1783786806; x=1784391606; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jZhjoM3HRleZk2ni0rE/sV17HuAJS+Lc2ckX2y0WT8g=;
        b=gXvLQF1bO3qqchk5qoXzrxm+JO4QrE/ghtktftwHfoYOIEI9tdlXJjIddGNnlHiGr/
         CcqPG1vuw+TWbj7MZjIWRg7tSDeOO/2jyBpkJsPuuR8mtgt9Y8xSrniESa6yx8rtJBqr
         SqbkeE1PFSbbjHA+r8G7lrSJT5yiedMEjYrIPNe5wUre9C8vdKzkyB7sHmYysm91E7Bd
         sRxaGtZvWmM01x7272mlOiRWkxWe6OwJ4QEHsyD3kk6QGPuT8y+2OfWTyigxx6I6R+3R
         WdfGaSN2bu9s+cZX3V92tnGeGAQnXFriyBTANCtoIBwbrZRRL/wDzKW0nEBVbjETyXMm
         3ong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783786806; x=1784391606;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jZhjoM3HRleZk2ni0rE/sV17HuAJS+Lc2ckX2y0WT8g=;
        b=nKGCBlZHN3wZcp4NP6bZyOb0Hs4Is13yg6LWBHZ4PjLxRTWAUubdFXLyFdQsAkLUHL
         SrA4I2Mqr30K753dnaQyezC4b50tXisTqG/uHzp40h0oIg0zCvhJyhm71xWmASBTfqhY
         +5RzUEoK9kttxwVBheX+69aPKsb8IQNxfPULpFZ5Yyag/f7EKqu7iithW6yaFmtuVYUZ
         KJbCBxAgR6Hdsd/3SrcuTzvlVUrXAP7pnooB/Z9l7LV/KULCgkErohHkuR93xe4GI/hH
         ar3K4Mv9x43kg7xGEgaKbaaRwSV9T9V7jHtIjxk1yBcZ6PzWP7nxzleSkOFg4err07GF
         5Ncg==
X-Forwarded-Encrypted: i=1; AHgh+RpGYfdg2Xjx522QzOiEIguDfK9wXXH6mcQySgpySJZdhNAT4nM2CiWMWh/0pC+SW+0Xz5BZS1s+Zkg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuilm2+VqAHvauKceuRaZ1oHPsLqGsx5t9xzpZPn/8rO2mUZui
	LdoTV0zOPRfVbYZKYlITRY/pFnLoe0i0fo54wUE0/vxxuHbfbyQLSHedP+Hv3HELELRFaHj8oeh
	1MbL0PD93zvBROwulYaFj0WEmxkEmm/bk2kIvqiBDil+5B8WP3Ic0kmYTJg7J4g==
X-Gm-Gg: AfdE7cmx4yCdwJC+3yrl1fcH8I8BjHMxTFjW194Hwohgdr5gQrHb0y+l2bjlPCc53r9
	cpcWnukQOlawSTbt1s4VS4TucQxA94+hMUOfa2ie7wUctkmjn5IYjXSpgpzYWYV0olcKFje2VAV
	lsre7jpDVNsTHZrxZfLLqiRpMK+bcLob+xQlMiHzKRZRogvtIBpTx18DTsTcE6boq/nrPIWHQaz
	AuGdoam8HYJXHJnvKpV2anZVhcVHP7q6vZvDKYfTM2L2X9A543y932O5Q4vEtOnlUZ6TYvavbLv
	4waoLFJdG3fT4CHaHte0sPXFAgDxfNYSFzYObxDdgftOnavgTK0qezXV1uffMgPzO8vQOkpLj/r
	2/sXfx/JmTXQ=
X-Received: by 2002:a05:622a:5805:b0:51a:8c97:fb9e with SMTP id d75a77b69052e-51cbf2ff16emr34067681cf.71.1783786805861;
        Sat, 11 Jul 2026 09:20:05 -0700 (PDT)
X-Received: by 2002:a05:622a:5805:b0:51a:8c97:fb9e with SMTP id d75a77b69052e-51cbf2ff16emr34067331cf.71.1783786805367;
        Sat, 11 Jul 2026 09:20:05 -0700 (PDT)
Received: from [172.31.1.12] ([70.105.248.123])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-51caab6e9f4sm39334051cf.2.2026.07.11.09.20.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jul 2026 09:20:04 -0700 (PDT)
Message-ID: <3ae163cd-d8f4-4d6b-8c62-999f92b294cf@redhat.com>
Date: Sat, 11 Jul 2026 12:20:02 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nfs-utils] nfsstat: display NFSv4 callback operation
 statistics
To: Jeff Layton <jlayton@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, NeilBrown <neil@brown.name>,
 Olga Kornievskaia <okorniev@redhat.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, Trond Myklebust <trondmy@kernel.org>,
 Anna Schumaker <anna@kernel.org>, linux-nfs@vger.kernel.org
References: <20260618-nfsstat-nl-v1-1-bd00f7e20b80@kernel.org>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20260618-nfsstat-nl-v1-1-bd00f7e20b80@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-23254-lists,linux-nfs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:chuck.lever@oracle.com,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:linux-nfs@vger.kernel.org,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steved@redhat.com,linux-nfs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 43039742277



On 6/18/26 1:24 PM, Jeff Layton wrote:
> The kernel now maintains per-operation call counts for the NFSv4
> backchannel (callback) operations it sends to clients, and exports them
> through the server-stats netlink dump as a new proc4cb-ops nested
> attribute (one server-proc-entry per callback opcode, OP_CB_GETATTR
> through OP_CB_OFFLOAD).
> 
> Add a "Server nfs v4 callback operations" section to nfsstat that
> reports these counts. The data is only available over netlink -- the
> /proc interface exposes nothing equivalent (only the single
> wdeleg_getattr line, which corresponds to CB_GETATTR) -- so the section
> is displayed solely when the stats were fetched via netlink. This is
> detected by srvproc4cbinfo[0] being non-zero, which the netlink handler
> sets from the entry count and the /proc parsers never touch.
> 
> The counters are indexed directly by RFC 8881 callback opcode, so the
> name array carries placeholders for the unassigned opcodes 0-2 to keep
> the array index aligned with the opcode value, mirroring the kernel's
> cb_counter layout.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> After the most recent review, we decided to add server side callback
> counts as a new feature for nfsstat. See the kernel patches here:
> 
> https://lore.kernel.org/linux-nfs/20260618-exportd-netlink-v5-0-e9aef947af3d@kernel.org/
Committed... (tag: nfs-utils-2-9-2-rc5)

steved.> ---
>   support/include/nfsd_netlink.h |  1 +
>   utils/nfsstat/nfsstat.c        | 46 +++++++++++++++++++++++++++++++++++++++---
>   2 files changed, 44 insertions(+), 3 deletions(-)
> 
> diff --git a/support/include/nfsd_netlink.h b/support/include/nfsd_netlink.h
> index 3d076d173b1d..87da1d0bb21e 100644
> --- a/support/include/nfsd_netlink.h
> +++ b/support/include/nfsd_netlink.h
> @@ -254,6 +254,7 @@ enum {
>   	NFSD_A_SERVER_STATS_PROC3_OPS,
>   	NFSD_A_SERVER_STATS_PROC4_OPS,
>   	NFSD_A_SERVER_STATS_PROC4OPS_OPS,
> +	NFSD_A_SERVER_STATS_PROC4CB_OPS,
>   
>   	__NFSD_A_SERVER_STATS_MAX,
>   	NFSD_A_SERVER_STATS_MAX = (__NFSD_A_SERVER_STATS_MAX - 1)
> diff --git a/utils/nfsstat/nfsstat.c b/utils/nfsstat/nfsstat.c
> index f09e1d6a447f..6717be502a82 100644
> --- a/utils/nfsstat/nfsstat.c
> +++ b/utils/nfsstat/nfsstat.c
> @@ -44,6 +44,8 @@ enum {
>   	SRVPROC4_SZ = 2,
>   	CLTPROC4_SZ = 59,
>   	SRVPROC4OPS_SZ = 71,
> +	SRVPROC4CB_SZ = 16,	/* indexed by callback opcode; OP_CB_OFFLOAD == 15 */
> +	SRVPROC4CB_FIRST = 3,	/* first assigned callback opcode, OP_CB_GETATTR */
>   };
>   
>   static unsigned int	srvproc2info[SRVPROC2_SZ+2],
> @@ -60,6 +62,8 @@ static unsigned int	cltproc4info[CLTPROC4_SZ+2],
>   			cltproc4info_old[CLTPROC4_SZ+2];	/* NFSv4 call counts ([0] == 49) */
>   static unsigned int	srvproc4opsinfo[SRVPROC4OPS_SZ+2],
>   			srvproc4opsinfo_old[SRVPROC4OPS_SZ+2];	/* NFSv4 call counts ([0] == 59) */
> +static unsigned int	srvproc4cbinfo[SRVPROC4CB_SZ+2],
> +			srvproc4cbinfo_old[SRVPROC4CB_SZ+2];	/* NFSv4 callback op counts (netlink only, [0] == 16) */
>   static unsigned int	srvnetinfo[5], srvnetinfo_old[5];	/* 0  # of received packets
>   								 * 1  UDP packets
>   								 * 2  TCP packets
> @@ -207,6 +211,19 @@ static const char *     nfssrvproc4opname[SRVPROC4OPS_SZ] = {
>   	"write_same",
>   };
>   
> +/*
> + * NFSv4 callback (backchannel) operations, indexed directly by RFC 8881
> + * callback opcode.  Opcodes 0-2 are not assigned, so the first three slots
> + * are placeholders to keep the array index aligned with the opcode value;
> + * display starts at SRVPROC4CB_FIRST and never prints them.
> + */
> +static const char *	nfssrvproc4cbname[SRVPROC4CB_SZ] = {
> +	"op0-unused",	"op1-unused",	"op2-unused",	"cb_getattr",
> +	"cb_recall",	"cb_layoutrecall", "cb_notify",	"cb_push_deleg",
> +	"cb_recall_any","cb_recall_obj","cb_recall_slot", "cb_sequence",
> +	"cb_wants_cancel", "cb_notify_lock", "cb_notify_devid", "cb_offload",
> +};
> +
>   #define LABEL_srvnet		"Server packet stats:\n"
>   #define LABEL_srvrpc		"Server rpc stats:\n"
>   #define LABEL_srvrc		"Server reply cache:\n"
> @@ -217,6 +234,7 @@ static const char *     nfssrvproc4opname[SRVPROC4OPS_SZ] = {
>   #define LABEL_srvproc3		"Server nfs v3:\n"
>   #define LABEL_srvproc4		"Server nfs v4:\n"
>   #define LABEL_srvproc4ops	"Server nfs v4 operations:\n"
> +#define LABEL_srvproc4cb	"Server nfs v4 callback operations:\n"
>   #define LABEL_cltnet		"Client packet stats:\n"
>   #define LABEL_cltrpc		"Client rpc stats:\n"
>   #define LABEL_cltproc2		"Client nfs v2:\n"
> @@ -250,6 +268,7 @@ typedef struct statinfo {
>   					SRV(proc3,s),\
>   					SRV(proc4,s), \
>   					SRV(proc4ops,s),\
> +					SRV(proc4cb,s),\
>   					{ NULL, NULL, 0, NULL }\
>   				}
>   #define DECLARE_CLT(n, s...)  	static statinfo n##s[] = { \
> @@ -683,14 +702,24 @@ print_server_stats(int opt_prt)
>   					nfssrvproc4name, srvproc4info + 1,
>   					sizeof(nfssrvproc4name)/sizeof(char *));
>   				print_callstats(LABEL_srvproc4ops,
> -					nfssrvproc4opname, srvproc4opsinfo + 1,
> +					nfssrvproc4opname, srvproc4opsinfo + 1,
>   					sizeof(nfssrvproc4opname)/sizeof(char *));
> +				/*
> +				 * Callback op counts are only available via
> +				 * netlink; srvproc4cbinfo[0] is left zero when
> +				 * stats come from /proc.
> +				 */
> +				if (srvproc4cbinfo[0])
> +					print_callstats(LABEL_srvproc4cb,
> +						nfssrvproc4cbname + SRVPROC4CB_FIRST,
> +						srvproc4cbinfo + 1 + SRVPROC4CB_FIRST,
> +						SRVPROC4CB_SZ - SRVPROC4CB_FIRST);
>   			}
>   		}
>   	}
>   }
>   static void
> -print_client_stats(int opt_prt)
> +print_client_stats(int opt_prt)
>   {
>   	if (opt_prt & PRNT_NET) {
>   		if (opt_sleep && !has_rpcstats(cltnetinfo, 4)) {
> @@ -806,8 +835,13 @@ print_serv_list(int opt_prt)
>   					nfssrvproc4name, srvproc4info + 1,
>   					sizeof(nfssrvproc4name)/sizeof(char *));
>   				print_callstats_list("nfs v4 servop",
> -					nfssrvproc4opname, srvproc4opsinfo + 1,
> +					nfssrvproc4opname, srvproc4opsinfo + 1,
>   					sizeof(nfssrvproc4opname)/sizeof(char *));
> +				if (srvproc4cbinfo[0])
> +					print_callstats_list("nfs v4 cback",
> +						nfssrvproc4cbname + SRVPROC4CB_FIRST,
> +						srvproc4cbinfo + 1 + SRVPROC4CB_FIRST,
> +						SRVPROC4CB_SZ - SRVPROC4CB_FIRST);
>   			}
>   		}
>   	}
> @@ -1228,6 +1262,12 @@ static int stats_nl_handler(struct nl_msg *msg, void *arg)
>   				parse_one_proc_entry(attr, si->valptr,
>   						     SRVPROC4OPS_SZ);
>   			break;
> +		case NFSD_A_SERVER_STATS_PROC4CB_OPS:
> +			si = get_stat_info("proc4cb", info);
> +			if (si)
> +				parse_one_proc_entry(attr, si->valptr,
> +						     SRVPROC4CB_SZ);
> +			break;
>   		}
>   	}
>   
> 
> ---
> base-commit: e4342316f4c93e88cce1382560c36dafbf4df58e
> change-id: 20260618-nfsstat-nl-70d465ab493b
> 
> Best regards,


