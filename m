Return-Path: <linux-nfs+bounces-22726-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SjJaGsepNWrg2gYAu9opvQ
	(envelope-from <linux-nfs+bounces-22726-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 22:42:47 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4716A7B0D
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 22:42:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=epUEzDrq;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-22726-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-nfs+bounces-22726-lists+linux-nfs=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA66B3051D58
	for <lists+linux-nfs@lfdr.de>; Fri, 19 Jun 2026 20:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D119330B30;
	Fri, 19 Jun 2026 20:40:28 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30BF53AA1A8;
	Fri, 19 Jun 2026 20:40:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781901628; cv=none; b=Wax+nBhmV2kztzDVcTjt9dhxJNKTVbZehTdHcitclff9gEYDxWRf7XGtfuzj+glDr+Hf8FSdqH/lwvMmbye7EtVHq09F4E2wLQjnp4CU5TL3eCI7g4xj0SYnRU/iWSIN8CbHqWbftVbPCxd4jLTOi+YNj52IGqz4dcKk8uVV5Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781901628; c=relaxed/simple;
	bh=8Jy6HDej5MVqW5P+aHe/rmzn+BwZeTHIv+YXrU/55wo=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=qGekMBabqqjm/dGQw8xZbbJsBhtAbnrxdNMSN1SIgdXnPkJDXqqM9CkpfmZ0YkvwzNzb5+VJZwcBxhLqlQ9tSCIDibK7Qs8/brZvsvFgR2Qwq/it9IDUxBxktaR4CiDR1IIbeTBzbMBlSU1lXWRdcWTweLxxo+YjnwAOIsx3o98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=epUEzDrq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE7A1F00A3D;
	Fri, 19 Jun 2026 20:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781901626;
	bh=61YvqUBYo64Wm4kxaJTeuWWillBrjtyLmr1yJmV3u+k=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject;
	b=epUEzDrq2EM95yyfRpdt22igJsyh2W9+7vgPjdXwIYTyyasQ/nr7hWXevM9i3+08r
	 tWhCYZf9PdkWuuCqiR91a8pv2cNCIJympVViBbkUfUz2zvX3HtpL+y72/CGemVXHmh
	 YdXmSLwTBuY1FyTcUy+hCQGQAYjBNhUMrbWojPH9Mmlgm4XhyOdXJ7r6exE/XU+ZVc
	 wuFdNqG1bOzh071ZPOlw/eIV5+e2TR2xn+2oZhXtMiwTXpScJo4bRQ4r9DkJV+qraS
	 Izo0LKKAlySb115jTe40bxjDrrSS7S8RbjSXgU0nM5l7hZ7osYqVM9MeslvTT+HBYQ
	 BmL9BMd1H7NGg==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id AEB4BF40088;
	Fri, 19 Jun 2026 16:40:25 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 19 Jun 2026 16:40:25 -0400
X-ME-Sender: <xms:Oak1apBe1VsDWNz-S9fHId-wHVTqdfbAqfJP7S1zX2ht92NWlJwn3A>
    <xme:Oak1aiV3HbWqqNNYvXk6NbK9LGylP9DIYzU1Zh1Wq3DRAGlpt3y40bi-ZpR-69FFE
    AumnDcbwCUnnNOvAKSLtbdvrz1b_2bcWjOD001vTn9SoCBWvBBZQf0>
X-ME-Proxy-Cause: dmFkZTGBEDObosTwV8Ot3MLEFaQ1yPV//jkQGY35DJPiK87gSq/EUvaE36aIcREYrJJr+q
    utREnGmpOt3kDjlbPnPoymtbS9uBAmDw5Aa+ErTk0nX5TSrW9WlAun1WuzQrlW7VGtcmlL
    jeF0qeQPP+ZdEl6sUVMPtRvlBFBIkVY7BuSNhWBfHcKjnpOD4Q/uj3BTXUmuvLj6tRWuWz
    f6+InE2dVgy39vMmtRCwxvaYuGoUmGcQ/D8/hV/b/5Dbli5IfmrQ0AvwrpD6l4rXAW2i+g
    d43wAh0hq5i8rMfOEemQMo3DDnSMOhguhP3Ajfjh2vK+yv0gyyqsv7OnsSMU89lLLVNzNk
    Od6v01NWZa57LfL39gWLvZtrCLbgMIsQcOG4mRbc7l1dEEUsjumGEBph2FVji9yXGk5PXs
    +DPpkPWKRGhr7gRMDBo6ixPKv70HXgBynIBZZSdEiRM8/lwvS+TBnzhHzVxU8gyAhWRRQI
    mKgrP7kjihhPt8fEEVOhSYwSAeP7NVLbdFd+FjZX2b2O8rVZ1Mgpj1kKuTvHMHs3jaUlTc
    XstoD4cwHkXwKmtfkOFFFzbnMod/u3Y/laozBqlxXprmeqk0487I9ZWoP8tWSzi7451D5T
    K5+esmFY5I3q0y6fjDrhqGZ+3YrU+LyWevCg7tQHlHcsVjq7FDeIzNUehFtA
X-ME-Proxy: <xmx:Oak1amswqLY4WWgME4Lomacq39g7zA9MyEH79uG-DHE0nMX3ABBBqQ>
    <xmx:Oak1ahc3wyYirkuMq-KX-uIL_yf9C418XO_Ca3VSElgfeXBXz0pysw>
    <xmx:Oak1asmHkTNj8IHaudp8hKJMpZU_jHKkm1_wEbKaLLebG64l3JMIiA>
    <xmx:Oak1akB3s_JTi_2L6HIx6nxcZAGy-p9oNFUdOZADtsT8TLtJxzIwLQ>
    <xmx:Oak1amMICIzyHXeYP8vngJRjtWuKyR1SJsDOViwtBtrHj2k0edu-FXE0>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 8A442780AB5; Fri, 19 Jun 2026 16:40:25 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: AxvleZyQkEuc
Date: Fri, 19 Jun 2026 16:40:05 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "Jeff Layton" <jlayton@kernel.org>, NeilBrown <neil@brown.name>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <Dai.Ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>
Cc: "Trond Myklebust" <trondmy@kernel.org>,
 "Anna Schumaker" <anna@kernel.org>, "Steve Dickson" <steved@redhat.com>,
 linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org
Message-Id: <8173debc-96fb-4354-ba11-dff99b772523@app.fastmail.com>
In-Reply-To: <20260619-exportd-netlink-v6-3-ddef3499793c@kernel.org>
References: <20260619-exportd-netlink-v6-0-ddef3499793c@kernel.org>
 <20260619-exportd-netlink-v6-3-ddef3499793c@kernel.org>
Subject: Re: [PATCH v6 3/6] nfsd: implement server-stats-get netlink handler
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.15 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-22726-lists,linux-nfs=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,app.fastmail.com:mid];
	FORGED_SENDER(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:tom@talpey.com,m:trondmy@kernel.org,m:anna@kernel.org,m:steved@redhat.com,m:linux-nfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BD4716A7B0D



On Fri, Jun 19, 2026, at 11:26 AM, Jeff Layton wrote:
> Implement nfsd_nl_server_stats_get_dumpit() which exposes the
> NFS server statistics currently available via /proc/net/rpc/nfsd
> through the nfsd generic netlink family.

A couple of questions on the dump design and one on the commit message,
then some smaller items.

The commit message says:

>   - First message: all scalar stats (reply cache, filehandle,
>     IO, network, RPC) plus per-version procedure counts
>     (proc2/3/4-ops) using per-netns vs_count arrays.
>
>   - Subsequent messages: NFSv4 per-operation counts
>     (proc4ops-ops), one entry per message, using cb->args[0]
>     to track the current operation index across dump calls.

The code does not stream across subsequent messages.  The proc4ops-ops
nests are emitted in the first message, inside the same "if (start == 0)"
block as the scalars, and cb->args[0] only ever holds 0 or -1, never an
operation index.  The function's own kerneldoc agrees: "The entire
server-stats object is emitted in a single netlink message on the first
invocation."

Should the commit message be reworded to match the code, or should the code
move to the streaming design the message describes?  That second option ties
into the next question.

> diff --git a/fs/nfsd/nfsctl.c b/fs/nfsd/nfsctl.c
> index 601301e34fc7..f0514d8149cd 100644
> --- a/fs/nfsd/nfsctl.c
> +++ b/fs/nfsd/nfsctl.c
> @@ -2329,6 +2329,185 @@ int nfsd_nl_cache_flush_doit(struct sk_buff *skb, struct genl_info *info)
>  	return 0;
>  }
>
> +static int nfsd_nl_fill_proc_ops(struct sk_buff *skb, int attr,
> +				 unsigned long __percpu *counts,
> +				 unsigned int nproc)
> +{
> +	struct nlattr *nest;
> +	unsigned int j;
> +	int k;
> +
> +	for (j = 0; j < nproc; j++) {
> +		unsigned long count = 0;
> +
> +		for_each_possible_cpu(k)
> +			count += per_cpu(counts[j], k);
> +
> +		nest = nla_nest_start(skb, attr);
> +		if (!nest)
> +			return -EMSGSIZE;
> +		if (nla_put_u32(skb, NFSD_A_SERVER_PROC_ENTRY_OP, j) ||
> +		    nla_put_u64_64bit(skb, NFSD_A_SERVER_PROC_ENTRY_COUNT,
> +				      count, NFSD_A_SERVER_PROC_ENTRY_PAD)) {
> +			nla_nest_cancel(skb, nest);
> +			return -EMSGSIZE;
> +		}
> +		nla_nest_end(skb, nest);
> +	}
> +
> +	return 0;
> +}
> +
> +/**
> + * nfsd_nl_server_stats_get_dumpit - dump NFS server statistics
> + * @skb: reply buffer
> + * @cb: netlink metadata and command arguments
> + *
> + * The entire server-stats object is emitted in a single netlink message on
> + * the first invocation. cb->args[0] is set to -1 afterwards so that the next
> + * invocation terminates the dump.
> + *
> + * Returns the size of the reply or a negative errno.
> + */
> +int nfsd_nl_server_stats_get_dumpit(struct sk_buff *skb,
> +				    struct netlink_callback *cb)
> +{
> +	struct net *net = sock_net(skb->sk);
> +	struct nfsd_net *nn = net_generic(net, nfsd_net_id);
> +	struct svc_stat *statp = &nn->nfsd_svcstats;
> +	struct svc_program *prog = statp->program;
> +	int start = cb->args[0];
> +	void *hdr;
> +
> +	/*
> +	 * cb->args[0] == 0: first call, emit the full server-stats object
> +	 * cb->args[0] < 0: dump already complete
> +	 */
> +	if (start < 0)
> +		return 0;
> +
> +	if (start == 0) {
> +		hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
> +				  cb->nlh->nlmsg_seq, &nfsd_nl_family,
> +				  NLM_F_MULTI, NFSD_CMD_SERVER_STATS_GET);
> +		if (!hdr)
> +			return -ENOBUFS;
> +

This handler assembles the entire server-stats object -- all scalars, the
proc2/3/4-ops nests, and one proc4ops-ops nest per NFSv4 operation -- in one
message under "if (start == 0)", then sets cb->args[0] = -1 so the next call
ends the dump.

Does that hold up once the assembled message no longer fits the dump buffer?
A dump skb is allocated at max(cb->min_dump_alloc, NLMSG_GOODSIZE), and this
handler sets neither cb->min_dump_alloc nor a .start callback, so the floor
is NLMSG_GOODSIZE, which is SKB_WITH_OVERHEAD(PAGE_SIZE), roughly 3.7k on a
4k-page host.  A larger skb is allocated only when userspace has previously
grown its receive buffer.

With LAST_NFS4_OP at 75, the proc4ops-ops loop alone emits 76 nests of about
28 bytes each (~2.1k); the proc2 and proc3 nests plus the scalar block bring
the total to roughly 3.5k -- already within a few hundred bytes of the floor,
and growing by one nest for every NFSv4 operation added later.

[ ... scalar puts for reply cache, fh, io, net, rpc snipped ... ]

> +		/* Per-version procedure counts */
> +		if (statp->vs_count) {
> +			static const int proc_attrs[] = {
> +				[2] = NFSD_A_SERVER_STATS_PROC2_OPS,
> +				[3] = NFSD_A_SERVER_STATS_PROC3_OPS,
> +				[4] = NFSD_A_SERVER_STATS_PROC4_OPS,
> +			};
> +			unsigned int i;
> +
> +			for (i = 0; i < prog->pg_nvers &&
> +			     i < ARRAY_SIZE(proc_attrs); i++) {
> +				if (!prog->pg_vers[i] ||
> +				    !statp->vs_count[i])
> +					continue;
> +				if (!proc_attrs[i])
> +					continue;
> +				if (nfsd_nl_fill_proc_ops(skb,
> +						proc_attrs[i],
> +						statp->vs_count[i],
> +						prog->pg_vers[i]->vs_nproc))
> +					goto err_cancel;
> +			}
> +		}
> +
> +#ifdef CONFIG_NFSD_V4
> +		/* NFSv4 individual operation counts */
> +		for (int i = 0; i <= LAST_NFS4_OP; i++) {
> +			struct nlattr *nest;
> +			u64 cnt;
> +
> +			cnt = percpu_counter_sum_positive(
> +				&nn->counter[NFSD_STATS_NFS4_OP(i)]);
> +
> +			nest = nla_nest_start(skb,
> +					NFSD_A_SERVER_STATS_PROC4OPS_OPS);
> +			if (!nest)
> +				goto err_cancel;
> +			if (nla_put_u32(skb, NFSD_A_SERVER_PROC_ENTRY_OP, i) ||
> +			    nla_put_u64_64bit(skb, NFSD_A_SERVER_PROC_ENTRY_COUNT,
> +					      cnt, NFSD_A_SERVER_PROC_ENTRY_PAD)) {
> +				nla_nest_cancel(skb, nest);
> +				goto err_cancel;
> +			}
> +			nla_nest_end(skb, nest);
> +		}
> +#endif

This loop open-codes the same nest that nfsd_nl_fill_proc_ops() builds just
above -- nla_nest_start(), nla_put_u32(PROC_ENTRY_OP),
nla_put_u64_64bit(PROC_ENTRY_COUNT), nla_nest_end() -- into the same
NFSD_A_SERVER_STATS_PROC4OPS_OPS attribute.  Could the helper be generalized
to take the per-op counter source so this is not a second copy of the same
code?

The per-version block above skips empty versions:

	if (!prog->pg_vers[i] || !statp->vs_count[i])
		continue;

but this loop emits an entry for every op 0..LAST_NFS4_OP, zero-count ops
included.  Is that difference intentional?  Skipping zero counts here would
also trim the worst-case message size above.

There is also a counter that this dump does not emit.  /proc/net/rpc/nfsd
prints a wdeleg_getattr line after proc4ops:

	seq_printf(seq, "\nwdeleg_getattr %lld",
		percpu_counter_sum_positive(&nn->counter[NFSD_STATS_WDELEG_GETATTR]));

incremented by nfsd_stats_wdeleg_getattr_inc().  Since the goal is to expose
the statistics currently available via /proc/net/rpc/nfsd, should
wdeleg_getattr get an attribute here too, so nfsstat over netlink does not
drop it relative to the procfs path?

> +
> +		genlmsg_end(skb, hdr);
> +	}
> +
> +	cb->args[0] = -1;
> +	return skb->len;
> +
> +err_cancel:
> +	genlmsg_cancel(skb, hdr);
> +	return -EMSGSIZE;
> +}

Back to the buffer question: when an nla_put eventually fails, control
reaches err_cancel, and genlmsg_cancel() trims the partial message back out,
so skb->len is 0 on return.  In netlink_dump():

	if (nlk->dump_done_errno == -EMSGSIZE && skb->len)
		nlk->dump_done_errno = skb->len;

the skb->len test fails, so -EMSGSIZE is delivered to userspace as a
terminal error rather than being taken as "buffer full, call again".  With
everything emitted under "if (start == 0)" and no per-attribute cursor in
cb->args, a retry rebuilds the same oversized message, so the dump cannot
ever complete.

nfsd_nl_rpc_status_get_dumpit() already follows the streaming pattern the
commit message describes: one entry per message, saving the cursor in
cb->args and returning skb->len on EMSGSIZE.  Would building this dump the
same way be more robust than the single-message form?

-- 
Chuck Lever

