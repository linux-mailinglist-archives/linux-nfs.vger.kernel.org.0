Return-Path: <linux-nfs+bounces-23256-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zaoZIExVU2qVZwMAu9opvQ
	(envelope-from <linux-nfs+bounces-23256-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 10:50:20 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B4F7744321
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 10:50:20 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=e9uXBDi5;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23256-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23256-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8699A3000FD8
	for <lists+linux-nfs@lfdr.de>; Sun, 12 Jul 2026 08:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C029939A807;
	Sun, 12 Jul 2026 08:50:14 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05573749ED;
	Sun, 12 Jul 2026 08:50:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783846213; cv=none; b=ALanhynf/bJOG+/JrzwtjNIQvR/Kps6qi2HKgqMjmmCl6Ve/VxgMveUkKRjxTEF1RD3dhanNEE4ZAKXLsz8ywKV/mGzjOcV2rbB5u3jhNgVm0ccWnaX4jU93Rq75YzgY6DvZ0rw69PyzcXQwjHhXtvn6Zxw5yQ8gOlUrBA1a+iA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783846213; c=relaxed/simple;
	bh=uIIfZjlpmIYUKgbV/gdQ5KaZ4+f5OBXWaH+NZ9I5MWo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RR8oNRdEwZ/5eKNntC42IOE1cCE2R92ycsiKMKyyRLEjRa2miw1yaI1sZamY3F7fgCBH7RL0YryzTkgFY3H6fVieBtRdH7CPjcX00V4aGuwrkPATXsM6/bJVux/oorMJTZB6yxo1zC2UBGFCyXNZl/BP578ZmWdZkF/vkKzfsZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e9uXBDi5; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927001F000E9;
	Sun, 12 Jul 2026 08:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783846210;
	bh=3/WQDuqK/NjChhbBxD3JTeFauC+f/uWS/uyRXi7bvcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=e9uXBDi5t/Gg6bKf6bIWllf5kORgw+CsndL1cYQve78SVa/u4E+4W6PQh+wiIIDfF
	 HdQ90R/K5XGn2MxrLR26hp+2ogq51C53RFkdnbRBI/IysdiTo7mZ1galQHJPe/qpg2
	 St/PmancZXHAe7eEllyoKCUDpTxfGEA1lAj8vzfZOEwODq4tPMCO38o/JVDtGKonDN
	 RbSBunSXd1ifaECsK+KY93bmateqV7gfwJXJuFRYzhSO451APa5GhGT88+OAEVTVr2
	 SuYvRd+gveLivi6QRyOt+1ClObAW9U8xA+DbU1sQnwGm+Wq+Ehcjj264X/qycRr9Sz
	 H0uaVmkwnxqpw==
Date: Sun, 12 Jul 2026 11:50:03 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, mkalderon@marvell.com,
	zyjzyj2000@gmail.com, sagi@grimberg.me, mgurtovoy@nvidia.com,
	haris.iqbal@ionos.com, jinpu.wang@ionos.com, bvanassche@acm.org,
	kbusch@kernel.org, Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>, kch@nvidia.com, smfrench@gmail.com,
	linkinjeon@kernel.org, metze@samba.org, tom@talpey.com,
	cel@kernel.org, jlayton@kernel.org, neil@brown.name,
	okorniev@redhat.com, Dai.Ngo@oracle.com, trondmy@kernel.org,
	anna@kernel.org, achender@kernel.org, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	horms@kernel.org, kees@kernel.org, michaelgur@nvidia.com,
	edwards@nvidia.com, phaddad@nvidia.com, eadavis@qq.com,
	yishaih@nvidia.com, kalesh-anakkur.purayil@broadcom.com,
	andriy.shevchenko@linux.intel.com, clm@meta.com,
	ebadger@purestorage.com, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, target-devel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org, linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org, rds-devel@oss.oracle.com,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH v10 rdma-next] RDMA: Change capability fields in
 ib_device_attr from int to u32
Message-ID: <20260712085003.GC33197@unreal>
References: <20260709055211.2498307-1-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260709055211.2498307-1-ernis@linux.microsoft.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-23256-lists,linux-nfs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[ziepe.ca,marvell.com,gmail.com,grimberg.me,nvidia.com,ionos.com,acm.org,kernel.org,kernel.dk,lst.de,samba.org,talpey.com,brown.name,redhat.com,oracle.com,davemloft.net,google.com,qq.com,broadcom.com,linux.intel.com,meta.com,purestorage.com,vger.kernel.org,lists.infradead.org,lists.samba.org,oss.oracle.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:ernis@linux.microsoft.com,m:jgg@ziepe.ca,m:mkalderon@marvell.com,m:zyjzyj2000@gmail.com,m:sagi@grimberg.me,m:mgurtovoy@nvidia.com,m:haris.iqbal@ionos.com,m:jinpu.wang@ionos.com,m:bvanassche@acm.org,m:kbusch@kernel.org,m:axboe@kernel.dk,m:hch@lst.de,m:kch@nvidia.com,m:smfrench@gmail.com,m:linkinjeon@kernel.org,m:metze@samba.org,m:tom@talpey.com,m:cel@kernel.org,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:trondmy@kernel.org,m:anna@kernel.org,m:achender@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kees@kernel.org,m:michaelgur@nvidia.com,m:edwards@nvidia.com,m:phaddad@nvidia.com,m:eadavis@qq.com,m:yishaih@nvidia.com,m:kalesh-anakkur.purayil@broadcom.com,m:andriy.shevchenko@linux.intel.com,m:clm@meta.com,m:ebadger@purestorage.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:target-devel@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:l
 inux-cifs@vger.kernel.org,m:samba-technical@lists.samba.org,m:linux-nfs@vger.kernel.org,m:netdev@vger.kernel.org,m:rds-devel@oss.oracle.com,m:jgg@nvidia.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-nfs@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCPT_COUNT_GT_50(0.00)[50];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-nfs@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vger.kernel.org:from_smtp,unreal:mid,nvidia.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1B4F7744321

On Wed, Jul 08, 2026 at 10:51:29PM -0700, Erni Sri Satya Vennela wrote:
> The capability counter fields in struct ib_device_attr are declared
> as signed int, but these values are inherently non-negative. Drivers
> maintain their cached caps as u32 and assign them directly into these
> int fields; if a cap exceeds INT_MAX the implicit narrowing yields a
> negative value visible to the IB core.
> 
> Change the signed int capability fields to u32 to match the
> underlying nature of the data. Also update consumers across the IB
> core, ULPs, NVMe-oF target, RDS, and NFS/RDMA so the new u32 values
> are not forced back through signed int or u8 via min()/min_t() or
> narrowing local variables.
> 
> The nvmet-rdma consumer of max_srq clamps it against
> ib_device.num_comp_vectors, which stays a signed int, so that site
> uses min_t() instead of min() to handle the signed/unsigned mismatch.
> 
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> Acked-by: Stefan Metzmacher <metze@samba.org> # smbdirect
> ---
> Changes in v10:
> * Convert max_srq to u32. Use min_t() against the still-signed ib_device.num_comp_vectors.
> * Update commit message.
> * Change rdma_restrack_count() to return u32 and make fill_res_info()'s curr and max u64.
> Changes in v9:
> * Switch the srq_size module parameter accessors to param_get_uint and
>   kstrtouint()/param_set_uint() so they match the now-unsigned
>   nvmet_rdma_srq_size variable.
> Changes in v8:
> * Convert the remaining non-negative counter fields max_ee_rd_atom,
>   max_ee_init_rd_atom, max_ee, max_rdd, max_raw_ipv6_qp and max_srq_wr
>   to u32; keep max_srq as int (its consumer compares it against
>   ib_device.num_comp_vectors, still int).
> * Drop all remaining min_t() where plain min() now works.
> * Make the srq_size module parameters unsigned int so the srq_size min()
>   stays a plain min().
> * Replace the ternary-inside-min() with the simpler "if (x) x--;".
> * Reorder the send_queue_depth min() to min(value, CONST) to match the
>   sibling site.
> * Restore reverse xmas-tree declaration order.
> * Collapse the min()/min3() assignments that now fit onto a single line
>   within 100 columns.
> * Print the now-u32 fields with %u instead of %d.
> Changes in v7:
> * Drop min_t() in all sites where a plain min() (or min3()) works
>   cleanly
> * Guard nvme/host/rdma.c num_inline_segments computation against a
>   device reporting max_send_sge == 0, so the u32 subtract
>   cannot wrap to UINT_MAX.
> * Use %u when printing the newly-u32 capability fields
>   in diagnostic messages.
> Changes in v6:
> * Fix subject prefix: net-next -> rdma-next.
> Changes in v5:
> * Add U8_MAX clamps in iser_verbs, nvme/host, nvme/target, isert,
> * rds/ib_cm, smbdirect/connect and smbdirect/accept where u32 capability
>   fields were directly narrowed into u8 rdma_conn_param fields without
>   clamping.
> * Guard the inline_sge_count calculation in nvmet_rdma_find_get_device()
>   to prevent u32 underflow when both max_sge_rd and max_recv_sge are
> zero.
> * Expand type migration to 9 additional fields (max_mw, max_raw_ethy_qp,
>   max_mcast_grp, max_mcast_qp_attach, max_total_mcast_qp_attach, max_ah,
>   max_srq, max_srq_wr, max_srq_sge)
> * Fix min_t(int,...) in svc_rdma_transport; min_t(u32,...) in ipoib,
>   srpt, nvme/target, rds/ib, rtrs-clt, rtrs-srv, xprtrdma/verbsdd.
> * Fix frwr_ops.c u32 underflow guard (reorder check before subtraction)
> * Change sc_max_send_sges to unsigned int, inline_sge_count to u32
> * Fix %d -> %u in rxe_qp, rxe_srq, ipoib_cm, ib_isert,
> * svc_rdma_transport
> * Update commit message.
> Changes in v4:
> * Drop clamping the values in mana_ib_query_device, instead update
>   the props values from int to u32.
> Changes in v3:
> * Drop clamping from mana_ib_gd_query_adapter_caps(). The internal u32
>   caps cache does not need to be clamped.
> * Move all clamping exclusively to mana_ib_query_device(), which is the
>   only place the cached u32 values are narrowed into the signed int
>   fields of struct ib_device_attr.
> * Reframe commit message: this is a u32-to-int type boundary fix, not a
>   CVM/untrusted-hardware hardening patch.
> Changes in v2:
> * Update patch title.
> ---
>  drivers/infiniband/core/cq.c               |  3 +-
>  drivers/infiniband/core/nldev.c            |  3 +-
>  drivers/infiniband/core/restrack.c         |  2 +-
>  drivers/infiniband/hw/qedr/verbs.c         |  2 +-
>  drivers/infiniband/sw/rxe/rxe_qp.c         | 22 ++++-----
>  drivers/infiniband/sw/rxe/rxe_srq.c        | 16 +++----
>  drivers/infiniband/ulp/ipoib/ipoib_cm.c    | 10 ++---
>  drivers/infiniband/ulp/ipoib/ipoib_verbs.c |  3 +-
>  drivers/infiniband/ulp/iser/iser_verbs.c   |  5 +--
>  drivers/infiniband/ulp/isert/ib_isert.c    |  7 ++-
>  drivers/infiniband/ulp/rtrs/rtrs-clt.c     | 11 ++---
>  drivers/infiniband/ulp/rtrs/rtrs-srv.c     | 11 ++---
>  drivers/infiniband/ulp/srp/ib_srp.c        |  2 +-
>  drivers/infiniband/ulp/srpt/ib_srpt.c      | 21 +++++----
>  drivers/nvme/host/rdma.c                   |  8 ++--
>  drivers/nvme/target/rdma.c                 | 26 ++++++-----
>  fs/smb/smbdirect/accept.c                  |  5 ++-
>  fs/smb/smbdirect/connect.c                 |  5 ++-
>  fs/smb/smbdirect/connection.c              |  8 ++--
>  include/linux/sunrpc/svc_rdma.h            |  4 +-
>  include/rdma/ib_verbs.h                    | 52 +++++++++++-----------
>  include/rdma/restrack.h                    |  2 +-
>  net/rds/ib.c                               | 10 ++---
>  net/rds/ib_cm.c                            | 10 ++---
>  net/sunrpc/xprtrdma/frwr_ops.c             |  7 +--
>  net/sunrpc/xprtrdma/svc_rdma_transport.c   |  5 +--
>  net/sunrpc/xprtrdma/verbs.c                |  2 +-
>  27 files changed, 129 insertions(+), 133 deletions(-)

This patch touches too many areas to delay it further. Let's merge it
now and improve it later, if needed.

Thanks

