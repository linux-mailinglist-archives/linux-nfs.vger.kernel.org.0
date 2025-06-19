Return-Path: <linux-nfs+bounces-12577-lists+linux-nfs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9A9DAE09C8
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Jun 2025 17:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 982423BF24D
	for <lists+linux-nfs@lfdr.de>; Thu, 19 Jun 2025 15:03:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C453128B7C2;
	Thu, 19 Jun 2025 15:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GbyxsNdf"
X-Original-To: linux-nfs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F350286D5B
	for <linux-nfs@vger.kernel.org>; Thu, 19 Jun 2025 15:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750345244; cv=none; b=QLf4cpFBfIEzxvP+V2nXfscEi1DFIm0GupMyfw5vKM9Tim7NymOu8p9OgkyxCc8UvlAE1q4371SVg/dJmWX1CKPXZ8v/nGRvPuqI/fbzV/CNnsFkVrLlOXZmPb7YjJvnmrx5gsPKETUQjnx5RnDxCSEq8lEgGE39EK7IaiwfIi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750345244; c=relaxed/simple;
	bh=pxwPEEFGC4JgHzmwUH6kOJePf9rIVXtnpWryVwoQflk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=af7qjzlFGlRim6ZzIk637G7Qa9x94Ue5o9K3IAiEvARzWXbi65TSsU5y7C1opDpYPZXX4jUBr/0RIL/kfx5IQeNWv1NyjEzOs9n7YMb6Uo3ipJhGzo+vlXC8LzdquY2zTHrzTgDuYEzQY1jEchrd2G7IYWxAX/z8Syuw7Pp4eic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GbyxsNdf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750345242;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GcfDdxTjBO5uztZW5izEldQPY3a3xrlr7c21c3VE6pM=;
	b=GbyxsNdf2lWJcI1vXbdat9xueQAzzvmofi/V2Ur3IXZWi0UnIadUYPZg41BQpO3AbEpnu1
	6e6atRGNQoFEK3zzLdqRTsolq+f8OW/Mx1QGWx6NkerBFrSeaJHjD8D1fXJjGcEpoT2IsJ
	NZ5D2hoIO3ETz8lqdxU9eASaGfHCXRM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-9-DcWN8ePJOumf6BP4yEKHfw-1; Thu,
 19 Jun 2025 11:00:29 -0400
X-MC-Unique: DcWN8ePJOumf6BP4yEKHfw-1
X-Mimecast-MFC-AGG-ID: DcWN8ePJOumf6BP4yEKHfw_1750345227
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 50C9E1800297;
	Thu, 19 Jun 2025 15:00:27 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.58.9])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D8D96195E344;
	Thu, 19 Jun 2025 15:00:25 +0000 (UTC)
From: Benjamin Coddington <bcodding@redhat.com>
To: kernel test robot <lkp@intel.com>
Cc: trondmy@kernel.org, anna@kernel.org, oe-kbuild-all@lists.linux.dev,
 linux-nfs@vger.kernel.org
Subject: Re: [PATCH] NFSv4/pNFS: Fix a race to wake on NFS_LAYOUT_DRAIN
Date: Thu, 19 Jun 2025 11:00:23 -0400
Message-ID: <A97BF2F5-146B-49AD-A3EE-7141F26DF521@redhat.com>
In-Reply-To: <202506192044.sMgMZpkZ-lkp@intel.com>
References: <43be0de9ff48ea68dec20d07cb235e164e634588.1750271744.git.bcodding@redhat.com>
 <202506192044.sMgMZpkZ-lkp@intel.com>
Precedence: bulk
X-Mailing-List: linux-nfs@vger.kernel.org
List-Id: <linux-nfs.vger.kernel.org>
List-Subscribe: <mailto:linux-nfs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-nfs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

On 19 Jun 2025, at 9:05, kernel test robot wrote:

> Hi Benjamin,
>
> kernel test robot noticed the following build warnings:
>
> [auto build test WARNING on trondmy-nfs/linux-next]
> [also build test WARNING on linus/master v6.16-rc2 next-20250618]
> [If your patch is applied to the wrong git tree, kindly drop us a note.=

> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Benjamin-Codding=
ton/NFSv4-pNFS-Fix-a-race-to-wake-on-NFS_LAYOUT_DRAIN/20250619-023749
> base:   git://git.linux-nfs.org/projects/trondmy/linux-nfs.git linux-ne=
xt
> patch link:    https://lore.kernel.org/r/43be0de9ff48ea68dec20d07cb235e=
164e634588.1750271744.git.bcodding%40redhat.com
> patch subject: [PATCH] NFSv4/pNFS: Fix a race to wake on NFS_LAYOUT_DRA=
IN
> config: x86_64-rhel-9.4 (https://download.01.org/0day-ci/archive/202506=
19/202506192044.sMgMZpkZ-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/arc=
hive/20250619/202506192044.sMgMZpkZ-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new ve=
rsion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202506192044.sMgMZpkZ-l=
kp@intel.com/
>
> All warnings (new ones prefixed by >>):
>
>    fs/nfs/pnfs.c: In function 'nfs_layoutget_end':
>>> fs/nfs/pnfs.c:2061:9: warning: this 'if' clause does not guard... [-W=
misleading-indentation]
>     2061 |         if (atomic_dec_and_test(&lo->plh_outstanding) &&
>          |         ^~
>    fs/nfs/pnfs.c:2064:17: note: ...this statement, but the latter is mi=
sleadingly indented as if it were guarded by the 'if'
>     2064 |                 wake_up_bit(&lo->plh_flags, NFS_LAYOUT_DRAIN=
);
>          |                 ^~~~~~~~~~~
>

Oh what shame, thanks robot. v2 incoming.

Ben


