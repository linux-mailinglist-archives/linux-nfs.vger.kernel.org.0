Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5164844428F
	for <lists+linux-nfs@lfdr.de>; Wed,  3 Nov 2021 14:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbhKCNlB (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 3 Nov 2021 09:41:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232012AbhKCNlA (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 3 Nov 2021 09:41:00 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1C38C061203
        for <linux-nfs@vger.kernel.org>; Wed,  3 Nov 2021 06:38:23 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:281:8300:104d::5f6])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 6C3145EB1;
        Wed,  3 Nov 2021 13:38:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 6C3145EB1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
        t=1635946702; bh=zdb/SzV7BitSZ4/81ZzDsIsH/OynNviHUgsEMO9omI4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=n8G0/6GaFgFpfV+vtdzxmav2NrKqtDSMsW4g2hvdt4KSO9HN80sd+HGvJnhaqaHVf
         Lysrvcc4wuwpSrdmsYI3lAniOAs7N+QSN4AKApwFGu5KchOJ3a5p54UAqX+HzWKBpE
         1bxXSlueuFxYN31a9tp7aqZFoa1evrEDwQXwWe9cNZNnr7iHJ4B3TdF+NzFKbfk2oB
         ZuxfAGv1H49X48aSd5MSuE5HBAq7z18jsNjvSXmi3EARczUC/Z35feO9XoRhV1QI7M
         CD0NmkDQZkCtbsiXV/FjwNCZsyF3BStoCS+5rZ4L2vqyqdi26lTV/6x+FTXkOsV3te
         xWpAO4WUiWIYw==
From:   Jonathan Corbet <corbet@lwn.net>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     "hch@lst.de" <hch@lst.de>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "anna.schumaker@netapp.com" <anna.schumaker@netapp.com>
Subject: Re: [PATCH 2/9] nfs: remove unused header <linux/pnfs_osd_xdr.h>
In-Reply-To: <08d283fbedab1be09a9dd6cf5a296c6a465a9394.camel@hammerspace.com>
References: <20211102220203.940290-1-corbet@lwn.net>
 <20211102220203.940290-3-corbet@lwn.net>
 <08d283fbedab1be09a9dd6cf5a296c6a465a9394.camel@hammerspace.com>
Date:   Wed, 03 Nov 2021 07:38:21 -0600
Message-ID: <87bl312wc2.fsf@meer.lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Trond Myklebust <trondmy@hammerspace.com> writes:

> Hi Jon,
>
> On Tue, 2021-11-02 at 16:01 -0600, Jonathan Corbet wrote:
>> Commit 19fcae3d4f2dd ("scsi: remove the SCSI OSD library") deleted
>> the last
>> file that included <linux/pnfs_osd_xdr.h> but left that file behind.=C2=
=A0
>> It's
>> unused, get rid of it now.
>>=20
>> Cc: Christoph Hellwig <hch@lst.de>
>> Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
>> Cc: Anna Schumaker <anna.schumaker@netapp.com>
>> Cc: linux-nfs@vger.kernel.org
>> Signed-off-by: Jonathan Corbet <corbet@lwn.net>
>
> Are you sending this directly to Linus or do you want me to take it
> through the NFS client tree? I'm fine either way.

Go ahead and take it, please, if that works; it's a bit off-topic for my
docs tree.

Thanks,

jon
