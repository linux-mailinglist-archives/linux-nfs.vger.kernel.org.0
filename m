Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8C352E4064
	for <lists+linux-nfs@lfdr.de>; Fri, 25 Oct 2019 01:40:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731633AbfJXXku (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 24 Oct 2019 19:40:50 -0400
Received: from mails2n1-route0.email.arizona.edu ([128.196.130.123]:46744 "EHLO
        mails2n1-route0.email.arizona.edu" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730783AbfJXXku (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 24 Oct 2019 19:40:50 -0400
IronPort-SDR: 76JSf6arLXyniC+0QU61xXarq8Ig9wR2PMV94HureDVskaKlfX+OTGGpRcGx/JqI0O6qundWjy
 F2Idn+8u+nqg==
IronPort-PHdr: =?us-ascii?q?9a23=3AxK3rZx80V+Jl5f9uRHKM819IXTAuvvDOBiVQ1K?=
 =?us-ascii?q?B41uIcTK2v8tzYMVDF4r011RmVBN6duqgP0bGempujcFRI2YyGvnEGfc4EfD?=
 =?us-ascii?q?4+ouJSoTYdBtWYA1bwNv/gYn9yNs1DUFh44yPzahANS47xaFLIv3K98yMZFA?=
 =?us-ascii?q?nhOgppPOT1HZPZg9iq2+yo9JDffgtFiCC5bL9sIxm6swvcvdQKjIV/Lao81g?=
 =?us-ascii?q?HHqWZSdeRMwmNoK1OTnxLi6cq14ZVu7Sdete8/+sBZSan1cLg2QrJeDDQ9Lm?=
 =?us-ascii?q?A6/9brugXZTQuO/XQTTGMbmQdVDgff7RH6WpDxsjbmtud4xSKXM9H6QawyVD?=
 =?us-ascii?q?+/6qdrSQToiDwGNz4//2Hcl9J+grtGqxKvphxw3YrUb5yIP/Z6cK7RYdYWSG?=
 =?us-ascii?q?xcVchTSiNBGJuxYZYBD+QBPuhWoYbyqFkSohWxHgSsGOHixyVUinPqwaE30e?=
 =?us-ascii?q?IsGhzG0gw6GNIOtWzZocv1NKgIV+C60a3IwivZb/hL3jry8pXHchUgofGKRr?=
 =?us-ascii?q?9wftTeyU8oFwPAkFqcs5bqPymU1uUMtGib6fBvWfixhGE6tgF8uz6izdovhI?=
 =?us-ascii?q?nRno8Z107I+CZjzIooIdC1SVR3bcOrHZZUrS2WKZV6Tt4kTmp1oig10KcGto?=
 =?us-ascii?q?S+fCUSzZQnwAPQZOKffoiT5xLjSP6RITBlhHJ5YL6/hwi98UynyuDkUsa4zU?=
 =?us-ascii?q?hGoylfntXRsn0A1gbf5tWIR/Z55EutxyiD2x3V5e1cIEA0k7TUK4I5z7ItiJ?=
 =?us-ascii?q?Yesl7PEjLylUj3lqOaa0op9+yy5+j5fLnqu4eQN4puhQH/NqQulNa/AeM9Mg?=
 =?us-ascii?q?UWRWeU5OG81Lzl/UDiT7VFkPs2kq7csJ/EP8gUvLS5Aw5U04Yk7RawFS2q38?=
 =?us-ascii?q?oFknkaNF5FYg6Ij5D1O1HSJ/D1FfO/g1WqkDd2yPHKJ7vhApvWLnXYjrfhcq?=
 =?us-ascii?q?hy61RGxAow099f/ZRUBa8FIP7pXU/xrtPYXVcXKQuxls3nAdNx0o4EETaGDq?=
 =?us-ascii?q?qYNovdvFmP4+9pKvONdogTsXDwJ+VztK2mtmMwhVJIJfrh5pAQcn3tRaxr?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: =?us-ascii?q?A2CtCQCyNbJd/92VxIBlHgELHIVbIBI?=
 =?us-ascii?q?ahDiJAodTBI8uhDGIAQEIAQEBDhMZAQIBAYRAAiODPjgTAgMJAQEBBAEBAQE?=
 =?us-ascii?q?BBQICAWyEa4MSDBmCaQkGIxVBEAgDDQ0CJgICV3SCRwGCUiWzR4EyGoU0gnc?=
 =?us-ascii?q?fCYFVgQ4ojCd4gQeBOAyCXz6HVRSCSgSBN4hfjB5Elmwfgg+BGAVfkyoGG4I?=
 =?us-ascii?q?rAYISiW0DiySoLYFpIoFYTSUTgVkKgUVPkhAhgTYIARUIEgEKAY54AQ?=
X-IPAS-Result: =?us-ascii?q?A2CtCQCyNbJd/92VxIBlHgELHIVbIBIahDiJAodTBI8uh?=
 =?us-ascii?q?DGIAQEIAQEBDhMZAQIBAYRAAiODPjgTAgMJAQEBBAEBAQEBBQICAWyEa4MSD?=
 =?us-ascii?q?BmCaQkGIxVBEAgDDQ0CJgICV3SCRwGCUiWzR4EyGoU0gncfCYFVgQ4ojCd4g?=
 =?us-ascii?q?QeBOAyCXz6HVRSCSgSBN4hfjB5Elmwfgg+BGAVfkyoGG4IrAYISiW0DiySoL?=
 =?us-ascii?q?YFpIoFYTSUTgVkKgUVPkhAhgTYIARUIEgEKAY54AQ?=
X-IronPort-AV: E=Sophos;i="5.68,226,1569308400"; 
   d="scan'208";a="425372090"
Received: from unknown (HELO [128.196.149.221]) ([128.196.149.221])
  by mails2n1out.email.arizona.edu with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2019 16:40:49 -0700
Subject: Re: NFS hangs on one interface
Cc:     linux-nfs@vger.kernel.org
References: <3447df77-1b2f-6d36-0516-3ae7267ab509@genome.arizona.edu>
 <20191023171523.GA18802@fieldses.org>
From:   Chandler <admin@genome.arizona.edu>
Message-ID: <b6248a82-1f1a-7329-5ee0-6e026f6db697@genome.arizona.edu>
Date:   Thu, 24 Oct 2019 16:40:49 -0700
MIME-Version: 1.0
In-Reply-To: <20191023171523.GA18802@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Thanks Bruce.
Do you (or anyone) have an idea how to use wireshark "tshark" on the command line to capture this data?  I tried to run it but it captures way too much traffic.. is there perhaps a certain port or ports I could tell it to monitor?  2049?  Thanks

