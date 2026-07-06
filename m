Return-Path: <linux-nfs+bounces-23060-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 08WbOWduS2ozRQEAu9opvQ
	(envelope-from <linux-nfs+bounces-23060-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 10:59:19 +0200
X-Original-To: lists+linux-nfs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4957A70E5FD
	for <lists+linux-nfs@lfdr.de>; Mon, 06 Jul 2026 10:59:19 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HQADDgAf;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-nfs+bounces-23060-lists+linux-nfs=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-nfs+bounces-23060-lists+linux-nfs=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF4B2301AA8F
	for <lists+linux-nfs@lfdr.de>; Mon,  6 Jul 2026 08:56:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1988E3FD12D;
	Mon,  6 Jul 2026 08:50:12 +0000 (UTC)
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE5C348866;
	Mon,  6 Jul 2026 08:49:58 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783327810; cv=none; b=PmPhE/I0H5XFU+WUY/4i1VzEnYMlSmG/LkNh5KPPWpqoKM7CLcoTCny+wQYECzsErKF5cjurP6WS21bqpbh5HQG8euMQvUUsvsNnbtt2evm7w4SE157SLqvptQm4uARF8bQ61vxqRC+5W4gcVRW2r9Z+RP1A2aViaBmI9+MUok4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783327810; c=relaxed/simple;
	bh=0x7pTVBQM/oo8cB6MYqUQ77YVRX8Kqn9XyTS7jKO4kI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NLuR3d3sq0017UEfGqb5GZxyTeETEIS7YGNmz1meaeCoE+XhreVYnDtvMrFGNX+4+7KEbbzNOvP3VA85jURtDSV3WBXe5ZzlFq9dRypBMlJQu7GD+iv38UL36mG5SBOQe5SVqhPtv4LKDdxl0F6XxB9qhzquTS4MEfnyFSfGqqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HQADDgAf; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 978CA1F000E9;
	Mon,  6 Jul 2026 08:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783327795;
	bh=9jiSSkCBnbVD7ihxmuDYCTOJSaEPHEl7wjng44WMYRs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=HQADDgAfKOb+QRTcxlAPYJxUo81CV+X2k0sH4dqu4MXUhUvI8d0gKIn3fSYrA1PX/
	 tkL8EscUhizGPIAmstyC+IcGi0Bpq2pmvmlHX04vH8BLW7siC04DcmJ3HXxv8hq27U
	 Cm3VdQdVL+4wwVwhFK7HQmPqA48e10qpeEhHd7fFACoRgnafr1d4FUho7fCK2UTrgb
	 YogOm5FOfD941STn0/3UYZu0szCwziMiufd32dSLEBhvVT9dg6Be1JIoRbfI00bgNA
	 1oij26/UKxOAPFBnCcX21MUoXrF/X4CgR3ssY2W31wgMyjX/YgrYc2fFtMVYhbR2Xe
	 VpXfNmIUilBiw==
Date: Mon, 6 Jul 2026 11:49:50 +0300
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
	horms@kernel.org, kees@kernel.org,
	andriy.shevchenko@linux.intel.com, clm@meta.com,
	ebadger@purestorage.com, linux-rdma@vger.kernel.org,
	linux-kernel@vger.kernel.org, target-devel@vger.kernel.org,
	linux-nvme@lists.infradead.org, linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org, linux-nfs@vger.kernel.org,
	netdev@vger.kernel.org, rds-devel@oss.oracle.com,
	Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH rdma-next v9] RDMA: Change capability fields in
 ib_device_attr from int to u32
Message-ID: <20260706084950.GK15188@unreal>
References: <20260703060329.896125-1-ernis@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260703060329.896125-1-ernis@linux.microsoft.com>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:ernis@linux.microsoft.com,m:jgg@ziepe.ca,m:mkalderon@marvell.com,m:zyjzyj2000@gmail.com,m:sagi@grimberg.me,m:mgurtovoy@nvidia.com,m:haris.iqbal@ionos.com,m:jinpu.wang@ionos.com,m:bvanassche@acm.org,m:kbusch@kernel.org,m:axboe@kernel.dk,m:hch@lst.de,m:kch@nvidia.com,m:smfrench@gmail.com,m:linkinjeon@kernel.org,m:metze@samba.org,m:tom@talpey.com,m:cel@kernel.org,m:jlayton@kernel.org,m:neil@brown.name,m:okorniev@redhat.com,m:Dai.Ngo@oracle.com,m:trondmy@kernel.org,m:anna@kernel.org,m:achender@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:kees@kernel.org,m:andriy.shevchenko@linux.intel.com,m:clm@meta.com,m:ebadger@purestorage.com,m:linux-rdma@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:target-devel@vger.kernel.org,m:linux-nvme@lists.infradead.org,m:linux-cifs@vger.kernel.org,m:samba-technical@lists.samba.org,m:linux-nfs@vger.kernel.org,m:netdev@vger.kernel.org,m:rds-devel@oss.oracle.com,m:
 jgg@nvidia.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[44];
	FORGED_SENDER(0.00)[leon@kernel.org,linux-nfs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-23060-lists,linux-nfs=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[leon@kernel.org,linux-nfs@vger.kernel.org];
	FREEMAIL_CC(0.00)[ziepe.ca,marvell.com,gmail.com,grimberg.me,nvidia.com,ionos.com,acm.org,kernel.org,kernel.dk,lst.de,samba.org,talpey.com,brown.name,redhat.com,oracle.com,davemloft.net,google.com,linux.intel.com,meta.com,purestorage.com,vger.kernel.org,lists.infradead.org,lists.samba.org,oss.oracle.com];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,nvidia.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,unreal:mid,samba.org:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4957A70E5FD

On Thu, Jul 02, 2026 at 11:02:57PM -0700, Erni Sri Satya Vennela wrote:
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
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Erni Sri Satya Vennela <ernis@linux.microsoft.com>
> Acked-by: Stefan Metzmacher <metze@samba.org> # smbdirect
> ---
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
>  drivers/infiniband/hw/qedr/verbs.c         |  2 +-
>  drivers/infiniband/sw/rxe/rxe_qp.c         | 22 +++++-----
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
>  drivers/nvme/target/rdma.c                 | 22 ++++++----
>  fs/smb/smbdirect/accept.c                  |  5 ++-
>  fs/smb/smbdirect/connect.c                 |  5 ++-
>  fs/smb/smbdirect/connection.c              |  8 ++--
>  include/linux/sunrpc/svc_rdma.h            |  4 +-
>  include/rdma/ib_verbs.h                    | 50 +++++++++++-----------
>  net/rds/ib.c                               | 10 ++---
>  net/rds/ib_cm.c                            | 10 ++---
>  net/sunrpc/xprtrdma/frwr_ops.c             |  7 +--
>  net/sunrpc/xprtrdma/svc_rdma_transport.c   |  5 +--
>  net/sunrpc/xprtrdma/verbs.c                |  2 +-
>  24 files changed, 122 insertions(+), 127 deletions(-)

The following code is still missing. Also, what about mxa_srq?
Why wasn't it converted as well?

diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nldev.c
index f599c24b34e8..aae4f3f6bcba 100644
--- a/drivers/infiniband/core/nldev.c
+++ b/drivers/infiniband/core/nldev.c
@@ -454,7 +454,8 @@ static int fill_res_info(struct sk_buff *msg, struct ib_device *device,
        };

        struct nlattr *table_attr;
-       int ret, i, curr, max;
+       u64 curr, max;
+       int ret, i;

        if (fill_nldev_handle(msg, device))
                return -EMSGSIZE;
diff --git a/drivers/infiniband/core/restrack.c b/drivers/infiniband/core/restrack.c
index cfee2071586c..1b2f9df49e28 100644
--- a/drivers/infiniband/core/restrack.c
+++ b/drivers/infiniband/core/restrack.c
@@ -61,7 +61,7 @@ void rdma_restrack_clean(struct ib_device *dev)
  * @type: actual type of object to operate
  * @show_details: count driver specific objects
  */
-int rdma_restrack_count(struct ib_device *dev, enum rdma_restrack_type type,
+u32 rdma_restrack_count(struct ib_device *dev, enum rdma_restrack_type type,
                        bool show_details)
 {
        struct rdma_restrack_root *rt = &dev->res[type];
diff --git a/include/rdma/restrack.h b/include/rdma/restrack.h
index 451f99e3717d..c081384740ce 100644
--- a/include/rdma/restrack.h
+++ b/include/rdma/restrack.h
@@ -123,7 +123,7 @@ struct rdma_restrack_entry {
        u32 id;
 };

-int rdma_restrack_count(struct ib_device *dev, enum rdma_restrack_type type,
+u32 rdma_restrack_count(struct ib_device *dev, enum rdma_restrack_type type,
                        bool show_details);
 /**
  * rdma_is_kernel_res() - check the owner of resource

