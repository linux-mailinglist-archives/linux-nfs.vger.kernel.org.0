Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4025EB02A3
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Sep 2019 19:26:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729130AbfIKR0X (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Sep 2019 13:26:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48178 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728897AbfIKR0X (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Wed, 11 Sep 2019 13:26:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CB7B030A76BE;
        Wed, 11 Sep 2019 17:26:22 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id F300F5DA5B;
        Wed, 11 Sep 2019 17:26:21 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Chuck Lever" <chuck.lever@oracle.com>
Cc:     "Jason L Tibbitts III" <tibbs@math.uh.edu>,
        "Bruce Fields" <bfields@fieldses.org>,
        "Wolfgang Walter" <linux@stwm.de>,
        "Linux NFS Mailing List" <linux-nfs@vger.kernel.org>,
        km@cm4all.com, linux-kernel@vger.kernel.org
Subject: Re: Regression in 5.1.20: Reading long directory fails
Date:   Wed, 11 Sep 2019 13:26:21 -0400
Message-ID: <429B2B1F-FB55-46C5-8BC5-7644CE9A5894@redhat.com>
In-Reply-To: <0089DF80-3A1C-4F0B-A200-28FF7CFD0C65@oracle.com>
References: <ufak1bhyuew.fsf@epithumia.math.uh.edu>
 <4418877.15LTP4gqqJ@stwm.de> <ufapnkhqjwm.fsf@epithumia.math.uh.edu>
 <4198657.JbNDGbLXiX@h2o.as.studentenwerk.mhn.de>
 <ufad0ggrfrk.fsf@epithumia.math.uh.edu> <20190906144837.GD17204@fieldses.org>
 <ufapnkdw3s3.fsf@epithumia.math.uh.edu>
 <75F810C6-E99E-40C3-B5E1-34BA2CC42773@oracle.com>
 <DD6B77EE-3E25-4A65-9D0E-B06EEAD32B31@redhat.com>
 <0089DF80-3A1C-4F0B-A200-28FF7CFD0C65@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.47]); Wed, 11 Sep 2019 17:26:23 +0000 (UTC)
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


On 11 Sep 2019, at 12:39, Chuck Lever wrote:

>> On Sep 11, 2019, at 12:25 PM, Benjamin Coddington 
>> <bcodding@redhat.com> wrote:
>>

>> Instead, I think we want to make sure the mic falls squarely into the 
>> tail
>> every time.
>
> I'm not clear how you could do that. The length of the page data is 
> not
> known to the client before it parses the reply. Are you suggesting 
> that
> gss_unwrap should do it somehow?

Is it too niave to always put the mic at the end of the tail?

Ben
