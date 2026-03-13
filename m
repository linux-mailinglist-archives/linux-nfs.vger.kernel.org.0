Return-Path: <linux-nfs+bounces-20145-lists+linux-nfs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-nfs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QDzTHm0EtGmXfgAAu9opvQ
	(envelope-from <linux-nfs+bounces-20145-lists+linux-nfs=lfdr.de@vger.kernel.org>)
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 13:34:53 +0100
X-Original-To: lists+linux-nfs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C7A828314F
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 13:34:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 53F6A300AB31
	for <lists+linux-nfs@lfdr.de>; Fri, 13 Mar 2026 12:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76B8F3932FB;
	Fri, 13 Mar 2026 12:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QBh3eSYJ"
X-Original-To: linux-nfs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53EC33932F4
	for <linux-nfs@vger.kernel.org>; Fri, 13 Mar 2026 12:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773405289; cv=none; b=aPXSveE3szAeH+ILE5Jmra5KRczOg6H2VuviRCf7mPlT14uALsOX59h0uTYt6XRbTpsCYp+YtmY2H3l5FP5wYNBPcv962FCvLp1UBknKn9oTbx5U9P32AIGwacbRDgaw3hj5X8Q1akxRIgMeW8appB9YMetg0T95WIMusosVpQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773405289; c=relaxed/simple;
	bh=q4NkIXz94tX49lQm0vCXwKQOPrCWBUwy5/8VXwwEplc=;
	h=MIME-Version:Date:From:To:Cc:Message-Id:In-Reply-To:References:
	 Subject:Content-Type; b=s8MkKKV0BZvRZmLmeIMZLkXMtkQVsB389I/vePbOU4FjNSjm6PUa0T6ZsLhkqgwvMEoXlMuLAYm5cSIuZVU6khTd42XIsxuctlaX3q0FK/fTEx0oLLWUug3F2yyXp0suePINUPffqNfYFTdUIV9uI1Pb/W1WFnIbNMuUpWmKfdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QBh3eSYJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF882C19423;
	Fri, 13 Mar 2026 12:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773405289;
	bh=q4NkIXz94tX49lQm0vCXwKQOPrCWBUwy5/8VXwwEplc=;
	h=Date:From:To:Cc:In-Reply-To:References:Subject:From;
	b=QBh3eSYJk2SC3dH2dF/xsDYTRRpu8CPM3fPm/iq6bP8GwYDN12OpZm6qfRPrVHDFu
	 J5YbEgxE36MXfoC8Vf1bfQYyOO1sd6N1dtO7x9RdCugQ7GgstfuJn21G/0IXdrKvri
	 DvbkPHXvZ6ebVgztVDNtvvfTbWxmdTPP9mp4/EAYr4cNsc8OEPo+wEfaCYhUyTzZmz
	 OfbbrU544qHCsiSyT3FG42QqDOWtZWZSkL1wKFY100OnYoY9JbptkK4ajjnvYMvOfe
	 Aq4hOrHaAhrkSD9gQ/r9goLeevxABjk4/0itXQhYzxSbV51AFQIdxHLjKxlaautq7F
	 WnVK+j997LwSw==
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfauth.phl.internal (Postfix) with ESMTP id CA78BF40068;
	Fri, 13 Mar 2026 08:34:47 -0400 (EDT)
Received: from phl-imap-15 ([10.202.2.104])
  by phl-compute-10.internal (MEProxy); Fri, 13 Mar 2026 08:34:47 -0400
X-ME-Sender: <xms:ZwS0aaEEAb8jhtBfMpXp2e8nAkKuBjqiKQSlY30wWIkpqx0jgw8kRg>
    <xme:ZwS0aWJykvs9-C2LMOh4njp1Doni3OGR59TpIqyAnjJWv6liuvlX8XO7fFhbFBxZ4
    XPP9nir84xS7RaUfU8bzdREAowOLo5anJ9JbUvI9smaR3X44NAaPl0B>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeelieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepofggfffhvfevkfgjfhfutgfgsehtjeertdertddtnecuhfhrohhmpedfvehhuhgt
    khcunfgvvhgvrhdfuceotggvlheskhgvrhhnvghlrdhorhhgqeenucggtffrrghtthgvrh
    hnpeeiveegteffveekveefkeejvdegjefhvdeutefggfekudffffevfeekveehteehkeen
    ucffohhmrghinhepghhithdqshgtmhdrtghomhdpghhithhhuhgsrdgtohhmpdhkvghrnh
    gvlhdrohhrghdptddurdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghm
    pehmrghilhhfrhhomheptghhuhgtkhhlvghvvghrodhmvghsmhhtphgruhhthhhpvghrsh
    honhgrlhhithihqdduieefgeelleelheelqdefvdelkeeggedvfedqtggvlheppehkvghr
    nhgvlhdrohhrghesfhgrshhtmhgrihhlrdgtohhmpdhnsggprhgtphhtthhopeduvddpmh
    houggvpehsmhhtphhouhhtpdhrtghpthhtoheplhhkphesihhnthgvlhdrtghomhdprhgt
    phhtthhopehjlhgrhihtohhnsehkvghrnhgvlhdrohhrghdprhgtphhtthhopehlvghonh
    eskhgvrhhnvghlrdhorhhgpdhrtghpthhtohepohgvqdhksghuihhlugdqrghllheslhhi
    shhtshdrlhhinhhugidruggvvhdprhgtphhtthhopehhtghhsehlshhtrdguvgdprhgtph
    htthhopegthhhutghkrdhlvghvvghrsehorhgrtghlvgdrtghomhdprhgtphhtthhopegu
    rghirdhnghhosehorhgrtghlvgdrtghomhdprhgtphhtthhopehnvghilhgssehofihnmh
    grihhlrdhnvghtpdhrtghpthhtohepohhkohhrnhhivghvsehrvgguhhgrthdrtghomh
X-ME-Proxy: <xmx:ZwS0aSCpbxYrKXsJ9J-J_StOEDtOr19xHwklpmxoVQm_lxCbmzzXzA>
    <xmx:ZwS0aS5BaNtEnmFTraT29RwPo6aMRneicx6N7aYDDzguELa9LikOrg>
    <xmx:ZwS0aR02S40YjsedhaafNZk-ZF2vNA00uhcAPdUHEJ20huF7utxUPA>
    <xmx:ZwS0aem3zSkeApCm01sNjyKell1D2BTywMq5XAoEZJDFCyK5kzEE4A>
    <xmx:ZwS0af6uiNHephBLroMPATSKcaqyF5uwOCbXdv9_GfunLsoWvueOSEs9>
Feedback-ID: ifa6e4810:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 9CFEB780070; Fri, 13 Mar 2026 08:34:47 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-ThreadId: A_hcazk5esrJ
Date: Fri, 13 Mar 2026 08:34:26 -0400
From: "Chuck Lever" <cel@kernel.org>
To: "kernel test robot" <lkp@intel.com>, NeilBrown <neilb@ownmail.net>,
 "Jeff Layton" <jlayton@kernel.org>,
 "Olga Kornievskaia" <okorniev@redhat.com>, "Dai Ngo" <dai.ngo@oracle.com>,
 "Tom Talpey" <tom@talpey.com>, "Leon Romanovsky" <leon@kernel.org>,
 "Christoph Hellwig" <hch@lst.de>
Cc: oe-kbuild-all@lists.linux.dev, linux-nfs@vger.kernel.org,
 linux-rdma@vger.kernel.org, "Chuck Lever" <chuck.lever@oracle.com>
Message-Id: <6264577a-784a-4501-b02f-bea8b4e49e27@app.fastmail.com>
In-Reply-To: <202603130922.uCz0Ofwx-lkp@intel.com>
References: <20260312134008.7387-3-cel@kernel.org>
 <202603130922.uCz0Ofwx-lkp@intel.com>
Subject: Re: [PATCH v2 2/2] svcrdma: Use contiguous pages for RDMA Read sink buffers
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.15 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[intel.com,ownmail.net,kernel.org,redhat.com,oracle.com,talpey.com,lst.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-20145-lists,linux-nfs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,git-scm.com:url];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cel@kernel.org,linux-nfs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-nfs];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1C7A828314F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr



On Fri, Mar 13, 2026, at 4:51 AM, kernel test robot wrote:
> Hi Chuck,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on v7.0-rc1]
> [also build test ERROR on next-20260312]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    
> https://github.com/intel-lab-lkp/linux/commits/Chuck-Lever/RDMA-rw-Fix-MR-pool-exhaustion-in-bvec-RDMA-READ-path/20260313-085521
> base:   v7.0-rc1
> patch link:    
> https://lore.kernel.org/r/20260312134008.7387-3-cel%40kernel.org
> patch subject: [PATCH v2 2/2] svcrdma: Use contiguous pages for RDMA 
> Read sink buffers
> config: x86_64-rhel-9.4 
> (https://download.01.org/0day-ci/archive/20260313/202603130922.uCz0Ofwx-lkp@intel.com/config)
> compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
> reproduce (this is a W=1 build): 
> (https://download.01.org/0day-ci/archive/20260313/202603130922.uCz0Ofwx-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new 
> version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: 
> https://lore.kernel.org/oe-kbuild-all/202603130922.uCz0Ofwx-lkp@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    net/sunrpc/xprtrdma/svc_rdma_rw.c: In function 'svc_rdma_fill_contig_bvec':
>>> net/sunrpc/xprtrdma/svc_rdma_rw.c:813:17: error: implicit declaration of function 'svc_rqst_page_release'; did you mean 'svc_rdma_cc_release'? [-Wimplicit-function-declaration]
>      813 |                 svc_rqst_page_release(rqstp,
>          |                 ^~~~~~~~~~~~~~~~~~~~~
>          |                 svc_rdma_cc_release

The current version of the series is missing a patch that provides
this helper function. Next version (if one is needed) will include
it.


> vim +813 net/sunrpc/xprtrdma/svc_rdma_rw.c
>
>    779	
>    780	/*
>    781	 * svc_rdma_fill_contig_bvec - Replace rq_pages with a 
> contiguous allocation
>    782	 * @rqstp: RPC transaction context
>    783	 * @head: context for ongoing I/O
>    784	 * @bv: bvec entry to fill
>    785	 * @pages_left: number of data pages remaining in the segment
>    786	 * @len_left: bytes remaining in the segment
>    787	 *
>    788	 * On success, fills @bv with a bvec spanning the contiguous 
> range and
>    789	 * advances rc_curpage/rc_page_count. Returns the byte length 
> covered,
>    790	 * or zero if the allocation failed or would overrun rq_maxpages.
>    791	 */
>    792	static unsigned int
>    793	svc_rdma_fill_contig_bvec(struct svc_rqst *rqstp,
>    794				  struct svc_rdma_recv_ctxt *head,
>    795				  struct bio_vec *bv, unsigned int pages_left,
>    796				  unsigned int len_left)
>    797	{
>    798		unsigned int order, alloc_nr, chunk_pages, chunk_len, i;
>    799		struct page *page;
>    800	
>    801		page = svc_rdma_alloc_read_pages(pages_left, &order);
>    802		if (!page)
>    803			return 0;
>    804		alloc_nr = 1 << order;
>    805	
>    806		if (head->rc_curpage + alloc_nr > rqstp->rq_maxpages) {
>    807			for (i = 0; i < alloc_nr; i++)
>    808				__free_page(page + i);
>    809			return 0;
>    810		}
>    811	
>    812		for (i = 0; i < alloc_nr; i++) {
>  > 813			svc_rqst_page_release(rqstp,
>    814					      rqstp->rq_pages[head->rc_curpage + i]);
>    815			rqstp->rq_pages[head->rc_curpage + i] = page + i;
>    816		}
>    817	
>    818		chunk_pages = min(alloc_nr, pages_left);
>    819		chunk_len = min_t(unsigned int, chunk_pages << PAGE_SHIFT, 
> len_left);
>    820		bvec_set_page(bv, page, chunk_len, 0);
>    821		head->rc_page_count += chunk_pages;
>    822		head->rc_curpage += chunk_pages;
>    823		return chunk_len;
>    824	}
>    825	
>
> -- 
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

-- 
Chuck Lever

