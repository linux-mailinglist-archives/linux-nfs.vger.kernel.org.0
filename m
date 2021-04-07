Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DDBF83574FA
	for <lists+linux-nfs@lfdr.de>; Wed,  7 Apr 2021 21:31:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355630AbhDGTbs (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 7 Apr 2021 15:31:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:27849 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345680AbhDGTbr (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 7 Apr 2021 15:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1617823897;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+DbR909La0k+wrobljrof49odopHHh3w5MC9CJo9MOg=;
        b=irae32FRRZOlfBKQLTKlSGFsJiaqwSgctQuuf4uf3W3qiId8+JnGph+4TpJLkHKaM5hkc3
        AVnm56KCGpuhorf1JYD97tCcStRNkELpOiPymlZSa67rzgC9hd1fW/6kec+rPymSIAbhQl
        H5eN3F80//av4xfSDWp35949g8p3Dsc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-JFkQiZ5ANF6Ikiqs1RTQZw-1; Wed, 07 Apr 2021 15:31:33 -0400
X-MC-Unique: JFkQiZ5ANF6Ikiqs1RTQZw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 366D519251A1;
        Wed,  7 Apr 2021 19:31:31 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (ovpn-112-148.phx2.redhat.com [10.3.112.148])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C29B55D9CA;
        Wed,  7 Apr 2021 19:31:30 +0000 (UTC)
Subject: Re: [PATCH 0/5 v2] nfs-utils: provide audit-logging of NFSv4 access
To:     "J. Bruce Fields" <bfields@fieldses.org>, NeilBrown <neilb@suse.de>
Cc:     Linux NFS Mailing list <linux-nfs@vger.kernel.org>
References: <161456493684.22801.323431390819102360.stgit@noble>
 <20210301185037.GB14881@fieldses.org>
 <874khui7hr.fsf@notabene.neil.brown.name>
 <20210302032733.GC16303@fieldses.org>
 <87y2ejerwn.fsf@notabene.neil.brown.name>
 <20210319132820.GA31533@fieldses.org>
 <87lfaieuoj.fsf@notabene.neil.brown.name>
 <20210319210922.GD31533@fieldses.org> <20210407191451.GA3663@fieldses.org>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <f62bdd53-eb2c-604e-8168-3ef9e9076253@RedHat.com>
Date:   Wed, 7 Apr 2021 15:33:41 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210407191451.GA3663@fieldses.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 4/7/21 3:14 PM, J. Bruce Fields wrote:
> On Fri, Mar 19, 2021 at 05:09:22PM -0400, J. Bruce Fields wrote:
>> On Sat, Mar 20, 2021 at 07:48:44AM +1100, NeilBrown wrote:
>>> On Fri, Mar 19 2021, J. Bruce Fields wrote:
>>>
>>>> On Fri, Mar 19, 2021 at 02:36:24PM +1100, NeilBrown wrote:
>>>>> On Mon, Mar 01 2021, J. Bruce Fields wrote:
>>>>>
>>>>>> On Tue, Mar 02, 2021 at 02:01:36PM +1100, NeilBrown wrote:
>>>>>>> On Mon, Mar 01 2021, J. Bruce Fields wrote:
>>>>>>>
>>>>>>>> I've gotten requests for similar functionality, and intended to
>>>>>>>> implement it using directory notifications on /proc/fs/nfsd/clients.
>>>>>>>
>>>>>>> I've been exploring this a bit.
>>>>>>> When I mount a filesystem, 2 clients get created.
>>>>>>> With NFSv4.0, the second client is immediately deleted, and the first
>>>>>>> client is deleted one grace period after the filesystem is unmounted.
>>>>>>> With NFSv4.1 and 4.2, the first client is immediately deleted, and the
>>>>>>> second client is deleted immediately after the unmount.
>>>>>>
>>>>>> Yeah, internally it's creating an "unconfirmed client" on SETCLIENTID
>>>>>> (or EXCHANGE_ID) and then a new "confirmed client" on
>>>>>> SETCLIENTID_CONFIRM (or CREATE_SESSION).
>>>>>>
>>>>>> I'm not sure why the ordering's a little different between the 4.0/4.1+
>>>>>> cases.
>>>>>
>>>>> The multiple clients are not really nfsd's "fault".  The Linux NFS
>>>>> client sends multiple EXCHANGE_ID or SET_CLIENT_ID requests, so NFSD
>>>>> really does need to create multiple clients.
>>>>>
>>>>> For NFSv4.0, when nfsd gets a repeat SET_CLIENT_ID, it keeps the old one
>>>>> and discards the new.
>>>>> For NFSv4.1, the spec requires that it keep the new one and discard the
>>>>> old.
>>>>> This explains the different ordering.
>>>>
>>>> Hm, is this the client's trunking-detection logic?
>>>
>>> Yes.
>>>
>>>>
>>>> In which case, it's not just unconfirmed clients.
>>>
>>> For NFSv4.1, only the EXCHANGE_ID is duplicate.  There is only one
>>> CREATE_SESSION, and that is where the client is confirmed.  So only one
>>> confirmed client.
>>>
>>> For NFSv4.0 bother SETCLIENTID and SETCLIENDID_CONFIRM are duplicate.
>>> So maybe both clients get confirmed.  I should check that.
>>
>> Drifting off topic, but I don't see how this client behavior makes
>> sense.  Mount is chatty enough without the unnecessary duplication.
>> Looking at the code....
> 
> I never sorted this out, by the way.  I think there must be a bug,
> though.
My bad... I didn't realize you had concern with the patch... 
What needs to happen... to figure this out?

steved.

