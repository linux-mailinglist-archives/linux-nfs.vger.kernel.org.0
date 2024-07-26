Return-Path: <linux-nfs+bounces-5078-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 055A493D932
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jul 2024 21:40:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 773D11F21417
	for <lists+linux-nfs@lfdr.de>; Fri, 26 Jul 2024 19:40:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D77B144C76;
	Fri, 26 Jul 2024 19:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="iuWBlAgz"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE29A3F9F9
	for <linux-nfs@vger.kernel.org>; Fri, 26 Jul 2024 19:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722022842; cv=none; b=UkRVIl6/gk7VtLew3Y8TdotQj9MdmCnn9sxSNstfMgEZl5H3msSobfetaa68DhqrzXPRyXpy0lo3Owj/rIwH3r+dG5ZG2Nv/q3MGanTbbjphvNTkCXL+YM6XIBXl2JFfwndAjopadT97G0IJmhJVGTQ9C0q3SkTp6YMw5ah5PZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722022842; c=relaxed/simple;
	bh=l1qfRoLol6UpITGvdMqxslGs/uUrIfYYLPsD//lj3aU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FmP4D+xqjTCxge3ya1B9c7uJu/rVXzXpfNkxckk4hqatY+lYZ71G/Q71gs/8N0W+o0rM7L/TGAtva3cjNN8F4oUvIaOW8o/VM+gk9wWu2O2hLZIwpQve5mLoELejbF9wskgoYHUVJVrYCFf+s3OmposcfTb8EmqOsr5fxtgU+2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=iuWBlAgz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722022839;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MU5Gp6u3eURoW33J0ADLXztxSrXCIA2WJRQMJretMB8=;
	b=iuWBlAgzmCatwiaDkTTdr5BtHhp3nmY8WbNBm3/W6FX1blkGWiF+MX73bce1aNm9grxDjp
	0emRyFAjmEotdResVWJQFGL7TYvSOBITFm9FT4nGji7K6Hz7lAG1MRzbsmF5x4fVSbAnL9
	Y9NwTMEw8vWj5dis5vzOi7AIkcux4v8=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-275-D6JEnGxOOimfoHsAW3ZnFQ-1; Fri, 26 Jul 2024 15:40:38 -0400
X-MC-Unique: D6JEnGxOOimfoHsAW3ZnFQ-1
Received: by mail-oo1-f70.google.com with SMTP id 006d021491bc7-5d5b4ffa0c8so189137eaf.1
        for <linux-nfs@vger.kernel.org>; Fri, 26 Jul 2024 12:40:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722022838; x=1722627638;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MU5Gp6u3eURoW33J0ADLXztxSrXCIA2WJRQMJretMB8=;
        b=amWr0zW4edGft+D28xDQrxmLLLi0HhSE3qnO605vKlWW5nkiJAMpD/3G/TwCqCU16j
         s0emTzIMDmwxsq8cX8Vgbi8AMb7g8kuavt2gfG3Pu+HckFyDDZ/ped3DB+rmOyVF+23X
         ATKEcyFDrhn5L6K0kIdFNoUSHqXXbnIlUKaDaHPa/JCvokUAVyTAW9D7MdN3Bl0Swi81
         Mdt71hzGR2Y1yn9XUs4Oo7F4SOeAaPNbigiXWJDVFTDFHfsXK1cnI1HSBLWPbTes4igk
         qYgk5DcJI2Yl1whSESH1sIIeqG/4tXz4AvKKHbk0wjpI1RM3rFJ/cvqoCNmfpOIe1LpS
         8ngg==
X-Gm-Message-State: AOJu0Yw4BxjNROmOi7tYZamjXNG8fw3Fo6VRJJSgk/Jxf7w8n6TehwGh
	VozawTegjM+hgZqUiczL704OB4dDnruhlftiBKVy2AYzlp1gIIs09Ro8osTt+ObuXNyPtODXA0p
	cONwqgndAPw1a79/v9qL1pzADoM8FIWeQOPr7+NJz93sV0ch6qf8np9D2Tw==
X-Received: by 2002:a05:6358:430e:b0:1ac:2b8b:a185 with SMTP id e5c5f4694b2df-1acfac8eddbmr471270155d.2.1722022837595;
        Fri, 26 Jul 2024 12:40:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG69utcts3AKw1i15OVMThtPOrA8BMt8dbETsUS7K1R0IxSuzCEhLh6RTIVmZe7k+6oAJNQJQ==
X-Received: by 2002:a05:6358:430e:b0:1ac:2b8b:a185 with SMTP id e5c5f4694b2df-1acfac8eddbmr471268755d.2.1722022837188;
        Fri, 26 Jul 2024 12:40:37 -0700 (PDT)
Received: from [172.31.1.12] ([70.109.163.123])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6bb3f925dc1sm19382196d6.65.2024.07.26.12.40.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jul 2024 12:40:36 -0700 (PDT)
Message-ID: <823ebc16-caf3-4658-9951-842fda8c6cbd@redhat.com>
Date: Fri, 26 Jul 2024 15:40:35 -0400
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH nfs-utils v6 0/3] nfsdctl: add a new nfsdctl tool to
 nfs-utils
To: Jeff Layton <jlayton@kernel.org>
Cc: linux-nfs@vger.kernel.org, Neil Brown <neilb@suse.de>,
 Olga Kornievskaia <kolga@netapp.com>, Dai Ngo <Dai.Ngo@oracle.com>,
 Tom Talpey <tom@talpey.com>, Chuck Lever <chuck.lever@oracle.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>
References: <20240722-nfsdctl-v6-0-1b9d63710eb5@kernel.org>
Content-Language: en-US
From: Steve Dickson <steved@redhat.com>
In-Reply-To: <20240722-nfsdctl-v6-0-1b9d63710eb5@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hey!

On 7/22/24 1:01 PM, Jeff Layton wrote:
> Hi Steve,
> 
> Here's an squashed version of the nfsdctl patches, that represents
> the latest changes. Let me know if you run into any other problems,
> and thanks for helping to test this!
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
> Changes in v6:
> - make the default number of threads 16 in autostart
> - doc updates
> 
> Changes in v5:
> - add support for pool-mode setting
> - fix up the handling of nfsd_netlink.h in autoconf
> - Link to v4: https://lore.kernel.org/r/20240604-nfsdctl-v4-0-a2941f782e4c@kernel.org
> 
> Changes in v4:
> - add ability to specify an array of pool thread counts in nfs.conf
> - Link to v3: https://lore.kernel.org/r/20240423-nfsdctl-v3-0-9e68181c846d@kernel.org
> 
> Changes in v3:
> - split nfsdctl.h so we can include the UAPI header as-is
> - squash the patches together that added Lorenzo's version and convert
>    it to the new interface
> - adapt to latest version of netlink interface changes
>    + have THREADS_SET/GET report an array of thread counts (one per pool)
>    + pass scope in as a string to THREADS_SET instead of using unshare() trick
> 
> Changes in v2:
> - Adapt to latest kernel netlink interface changes (in particular, send
>    the leastime and gracetime when they are set in the config).
> - More help text for different subcommands
> - New nfsdctl(8) manpage
> - Patch to make systemd preferentially use nfsdctl instead of rpc.nfsd
> - Link to v1: https://lore.kernel.org/r/20240412-nfsdctl-v1-0-efd6dcebcc04@kernel.org
> 
> ---
> Jeff Layton (3):
>        nfsdctl: add the nfsdctl utility to nfs-utils
>        nfsdctl: asciidoc source for the manpage
>        systemd: use nfsdctl to start and stop the nfs server
> 
>   configure.ac                 |   19 +
>   systemd/nfs-server.service   |    4 +-
>   utils/Makefile.am            |    4 +
>   utils/nfsdctl/Makefile.am    |   13 +
>   utils/nfsdctl/nfsd_netlink.h |   96 +++
>   utils/nfsdctl/nfsdctl.8      |  304 ++++++++
>   utils/nfsdctl/nfsdctl.adoc   |  158 +++++
>   utils/nfsdctl/nfsdctl.c      | 1570 ++++++++++++++++++++++++++++++++++++++++++
>   utils/nfsdctl/nfsdctl.h      |   93 +++
>   9 files changed, 2259 insertions(+), 2 deletions(-)
> ---
> base-commit: b76dbaa48f7c239accb0c2d1e1d51ddd73f4d6be
> change-id: 20240412-nfsdctl-fa8bd8430cfd

The patches apply very cleaning and thank you
for squashing them down... but... bring up the
NFS server with 'nfsdctl autostart' v3 is not
being registered with rpcbind which means
v3 mount will not work.

Just curious are you trying support my
idea of deprecating V3 :-) (That's a joke!)

steved.


