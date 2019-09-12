Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 92B9AB1013
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2019 15:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731650AbfILNfK (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Sep 2019 09:35:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57126 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731283AbfILNfK (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 12 Sep 2019 09:35:10 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 32D2E806A42;
        Thu, 12 Sep 2019 13:35:10 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 389E85D9E5;
        Thu, 12 Sep 2019 13:35:09 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     bfields@fieldses.org, tibbs@math.uh.edu, linux@stwm.de,
        linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        km@cm4all.com, chuck.lever@oracle.com
Subject: Re: Regression in 5.1.20: Reading long directory fails
Date:   Thu, 12 Sep 2019 09:35:08 -0400
Message-ID: <E3D5BD21-8D9D-4EBE-A607-5D4BC9692C63@redhat.com>
In-Reply-To: <db42c87ba2c5b0852ad42ba51792ee67ab036a37.camel@hammerspace.com>
References: <DD6B77EE-3E25-4A65-9D0E-B06EEAD32B31@redhat.com>
 <0089DF80-3A1C-4F0B-A200-28FF7CFD0C65@oracle.com>
 <429B2B1F-FB55-46C5-8BC5-7644CE9A5894@redhat.com>
 <F1EC95D2-47A3-4390-8178-CAA8C045525B@oracle.com>
 <8D7EFCEB-4AE6-4963-B66F-4A8EEA5EA42A@redhat.com>
 <FAA4DD3D-C58A-4628-8FD5-A7E2E203B75A@redhat.com>
 <B8CDE765-7DCE-4257-91E1-CC85CB7F87F7@oracle.com>
 <EC2B51FB-8C22-4513-B59F-0F0741F694EB@redhat.com>
 <c8bc4f95e7a097b01e5fff9ce5324e32ee9d8821.camel@hammerspace.com>
 <57185A91-0AC8-4805-B6CE-67D629F814C2@redhat.com>
 <20190912131359.GB31879@fieldses.org>
 <db42c87ba2c5b0852ad42ba51792ee67ab036a37.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.67]); Thu, 12 Sep 2019 13:35:10 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 12 Sep 2019, at 9:25, Trond Myklebust wrote:

> On Thu, 2019-09-12 at 09:13 -0400, J. Bruce Fields wrote:
>> (Unless I'm missing something.  I haven't looked at this code in a
>> while.  Though it was problem me that wrote it originally--apologies
>> for
>> that....)
>>
>
> The function itself is fine. It was just the name I'm objecting to,
> since we're actually moving the last 'n' bytes in the message in order
> to be able to read them.

Ok, that's helpful guidance since it saves me from doing a stable fix and
then an attempt to rename/optimize/breakitagain.

I'll just rename it at the same time as the fix.. but now I wonder if that
can potentially mess up other fixes that might retroactively get sent to
stable.  Maybe I'm over thinking it.  I guess I'll send the fix and then the
rename separately, and maintainers can squash at will.

Ben
