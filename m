Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4CD154C1B0
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jun 2019 21:46:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727002AbfFSTqz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Jun 2019 15:46:55 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:48162 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfFSTqz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Jun 2019 15:46:55 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5JJiVLh092705;
        Wed, 19 Jun 2019 19:46:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2018-07-02; bh=QVRqm+sSfD1IIKZiAHX79QvCZaoVhPBGSSmhp+dv5r4=;
 b=eyG1fw7bTnmu+zm/YHS20ja8f8JJd4E5TTQusRSxhYFmo/gGsV0BvLKI3vdkjJzOFP8v
 EDBmKCjydxw+qHtMq+RnDlljIQpGNlpRFo5Ovi/7noQ54LPrGNxv1Gc45gByySN3iIlP
 QUVw0YMlKMCjSl+rBOwRikvvJxOCkRyWCu4wNbqsItkfPKaqxyFqhIHEgj1IWQBk2Sdx
 /3DE9hA/t6B3NKUAeMT2tpJUzaF2d+jauBX1+iynUL9wh1wRjaSQtG0Ndc44+PHVfG2l
 SK4S366oum2sg44Y3fCYGN9WLu3vvbh+qXATzrWjfiGQ/y2Q9yBr/5bwQAkSUWbPPScZ Fg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 2t7809dd8u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 19:46:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5JJjFXk155969;
        Wed, 19 Jun 2019 19:46:28 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3030.oracle.com with ESMTP id 2t7rdwtxkn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 19:46:27 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5JJkPcB007716;
        Wed, 19 Jun 2019 19:46:26 GMT
Received: from anon-dhcp-171.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Jun 2019 12:46:25 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH 3/3] mountstats: Check for RPC iostats version >= 1.1 with
 error counts
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <449f121418f5667436e6d42432c6404aa0fed9e9.camel@redhat.com>
Date:   Wed, 19 Jun 2019 15:46:24 -0400
Cc:     Steve Dickson <SteveD@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: 7bit
Message-Id: <DB163079-2AE4-4C1E-A317-27E1F9745788@oracle.com>
References: <20190612190229.31811-1-dwysocha@redhat.com>
 <20190613120314.1864-1-dwysocha@redhat.com>
 <20190613120314.1864-3-dwysocha@redhat.com>
 <FD291454-53BB-46DB-BEBE-9AA2F8DE18DE@oracle.com>
 <CALF+zOkFKXZQsFodJphAg1UBNxKyQq_GfO1wFqfak0TTre=dng@mail.gmail.com>
 <7211D5DF-6923-459D-9B84-2BD264EB9F11@oracle.com>
 <E3BDBBD8-C75C-48EA-85D5-37657DF3AE14@oracle.com>
 <449f121418f5667436e6d42432c6404aa0fed9e9.camel@redhat.com>
To:     Dave Wysochanski <dwysocha@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9293 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906190162
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9293 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906190162
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jun 19, 2019, at 3:42 PM, Dave Wysochanski <dwysocha@redhat.com> wrote:
> 
> On Wed, 2019-06-19 at 13:45 -0400, Chuck Lever wrote:
>>> On Jun 19, 2019, at 1:42 PM, Chuck Lever <chuck.lever@oracle.com>
>>> wrote:
>>> 
>>> 
>>> 
>>>> On Jun 19, 2019, at 1:22 PM, David Wysochanski <
>>>> dwysocha@redhat.com> wrote:
>>>> 
>>>> 
>>>> 
>>>> On Wed, Jun 19, 2019 at 12:35 PM Chuck Lever <
>>>> chuck.lever@oracle.com> wrote:
>>>> 
>>>> 
>>>>> On Jun 13, 2019, at 8:03 AM, Dave Wysochanski <
>>>>> dwysocha@redhat.com> wrote:
>>>>> 
>>>>> Add explicit check for statsvers instead of array based check.
>>>> 
>>>> Hi Dave,
>>>> 
>>>> I don't understand why this change is necessary. The patch
>>>> description
>>>> should explain.
>>>> 
>>>> 
>>>> Steve had already taken commit 73491ef for mountstats which was
>>>> an array based check.  This just makes this patch consistent with
>>>> the others.  Is that what you mean - you want a statement about
>>>> consistency and refer to the other commit?  How about:
>>>> 
>>>> Commit 73491ef added per-op error counts for mountstats command
>>>> but used an array based check rather than checking statsver. Add
>>>> explicit check for statsver instead of array based check for
>>>> consistency with other tools.
>>> 
>>> This is a better patch description (explains "why" not "what"),
>>> but I'm not clear why this change is necessary in either place.
>> 
>> In other words, was this change necessary to fix a bug? Or is
>> this a defensive change to make parsing more robust?
>> 
> 
> I try to state "fix" somewhere in there when it is a bug fix - so no
> this does not fix a bug.  In in some ways the original check was better
> because it makes no assumption of what 'statsver' means at any time. 
> I'm not sure if you're really concerned about the commit message or you
> would prefer the array check?

Both. The array check is done for all the other variables too, IIRC.
There doesn't seem to be a reason to check the statvers. If it's not
too much trouble, please resubmit so that the new checks are consistent
with existing checks.


> I can see argument for array check and I
> can change the other patches and resubmit if you prefer that.
> 
> Commit 73491ef added per-op error counts for mountstats command
> but used an array based check rather than checking statsver.  Check
> statsver >= 1.1 explicitly as this documents when this new count was
> added to the kernel.

Not sure there's a need for the statvers bump here either. There
are some rules about when a statvers bump is necessary, but in my
old age I don't remember what they are. Anyway, if the statvers is
bumped already, no big deal.


>>>>> Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
>>>>> ---
>>>>> tools/mountstats/mountstats.py | 2 +-
>>>>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>>>> 
>>>>> diff --git a/tools/mountstats/mountstats.py
>>>>> b/tools/mountstats/mountstats.py
>>>>> index 5f13bf8e..2ebbf945 100755
>>>>> --- a/tools/mountstats/mountstats.py
>>>>> +++ b/tools/mountstats/mountstats.py
>>>>> @@ -476,7 +476,7 @@ class DeviceData:
>>>>>               if retrans != 0:
>>>>>                   print('\t%d retrans (%d%%)' % (retrans,
>>>>> ((retrans * 100) / count)), end=' ')
>>>>>                   print('\t%d major timeouts' % stats[3],
>>>>> end='')
>>>>> -                if len(stats) >= 10 and stats[9] != 0:
>>>>> +                if self.__rpc_data['statsvers'] >= 1.1 and
>>>>> stats[9] != 0:
>>>>>                   print('\t%d errors (%d%%)' % (stats[9],
>>>>> ((stats[9] * 100) / count)))
>>>>>               else:
>>>>>                   print('')
>>>>> -- 
>>>>> 2.20.1
>>>>> 
>>>> 
>>>> --
>>>> Chuck Lever
>>>> 
>>>> 
>>>> 
>>>> 
>>>> 
>>>> -- 
>>>> Dave Wysochanski
>>>> Principal Software Maintenance Engineer
>>>> T: 919-754-4024  
>>> 
>>> --
>>> Chuck Lever
>> 
>> --
>> Chuck Lever

--
Chuck Lever



