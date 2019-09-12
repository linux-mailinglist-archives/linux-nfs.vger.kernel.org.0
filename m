Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E451CB0F95
	for <lists+linux-nfs@lfdr.de>; Thu, 12 Sep 2019 15:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731749AbfILNIy (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 12 Sep 2019 09:08:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58168 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731283AbfILNIx (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 12 Sep 2019 09:08:53 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 8B4CF8BA2DA;
        Thu, 12 Sep 2019 13:08:53 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7AE02600C4;
        Thu, 12 Sep 2019 13:08:52 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     chuck.lever@oracle.com, tibbs@math.uh.edu, bfields@fieldses.org,
        linux@stwm.de, linux-nfs@vger.kernel.org,
        linux-kernel@vger.kernel.org, km@cm4all.com
Subject: Re: Regression in 5.1.20: Reading long directory fails
Date:   Thu, 12 Sep 2019 09:08:51 -0400
Message-ID: <57185A91-0AC8-4805-B6CE-67D629F814C2@redhat.com>
In-Reply-To: <c8bc4f95e7a097b01e5fff9ce5324e32ee9d8821.camel@hammerspace.com>
References: <ufak1bhyuew.fsf@epithumia.math.uh.edu>
 <4418877.15LTP4gqqJ@stwm.de> <ufapnkhqjwm.fsf@epithumia.math.uh.edu>
 <4198657.JbNDGbLXiX@h2o.as.studentenwerk.mhn.de>
 <ufad0ggrfrk.fsf@epithumia.math.uh.edu> <20190906144837.GD17204@fieldses.org>
 <ufapnkdw3s3.fsf@epithumia.math.uh.edu>
 <75F810C6-E99E-40C3-B5E1-34BA2CC42773@oracle.com>
 <DD6B77EE-3E25-4A65-9D0E-B06EEAD32B31@redhat.com>
 <0089DF80-3A1C-4F0B-A200-28FF7CFD0C65@oracle.com>
 <429B2B1F-FB55-46C5-8BC5-7644CE9A5894@redhat.com>
 <F1EC95D2-47A3-4390-8178-CAA8C045525B@oracle.com>
 <8D7EFCEB-4AE6-4963-B66F-4A8EEA5EA42A@redhat.com>
 <FAA4DD3D-C58A-4628-8FD5-A7E2E203B75A@redhat.com>
 <B8CDE765-7DCE-4257-91E1-CC85CB7F87F7@oracle.com>
 <EC2B51FB-8C22-4513-B59F-0F0741F694EB@redhat.com>
 <c8bc4f95e7a097b01e5fff9ce5324e32ee9d8821.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.68]); Thu, 12 Sep 2019 13:08:53 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 12 Sep 2019, at 8:53, Trond Myklebust wrote:
> Let's please just scrap this function and rewrite it as a generic
> function for reading the MIC. It clearly is not a generic function for
> reading arbitrary netobjs, and modifications like the above just make
> the misnomer painfully obvious.
>
> Let's rewrite it as xdr_buf_read_mic() so that we can simplify it where
> possible.

Ok.  I want to assume the mic will not land in the head, but I am not sure..
Is there a scenario where the mic might land in the head, or is that bit of
the current function left over from other uses?

Ben
