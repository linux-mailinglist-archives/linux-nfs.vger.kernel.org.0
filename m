Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8D22AAAA3
	for <lists+linux-nfs@lfdr.de>; Sun,  8 Nov 2020 12:05:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727348AbgKHLFz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 8 Nov 2020 06:05:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28738 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726206AbgKHLFy (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 8 Nov 2020 06:05:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1604833552;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KsoNREw63315QvLVsvyAa7++kevnzcpy+etDWq/Mo/Y=;
        b=UJsT6dz/dr7KZRis6zYhDuh0O0YqZx3bgRfC72JKUW09nSfLq+BzhnqjUROkVyDwduqkWw
        1XuCSA2EgNWIAjZ/Vbzc4OkPQcExOJcVfuWPYikydRWd/DODNukmZegD/8J5o1qbfzMuCp
        MzDMezK0/cKlQ63vJo3jvsbHVnOfbTs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-MgHKP4s_Me2J9MucIIf7kg-1; Sun, 08 Nov 2020 06:05:48 -0500
X-MC-Unique: MgHKP4s_Me2J9MucIIf7kg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E48958030AD;
        Sun,  8 Nov 2020 11:05:47 +0000 (UTC)
Received: from [172.16.176.1] (ovpn-64-2.rdu2.redhat.com [10.10.64.2])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9816E10013BD;
        Sun,  8 Nov 2020 11:05:47 +0000 (UTC)
From:   "Benjamin Coddington" <bcodding@redhat.com>
To:     "Trond Myklebust" <trondmy@hammerspace.com>
Cc:     linux-nfs@vger.kernel.org
Subject: Re: [PATCH v3 00/17] Readdir enhancements
Date:   Sun, 08 Nov 2020 06:05:46 -0500
Message-ID: <0629C8A7-5E4F-4BC0-8346-B8497FDE81F2@redhat.com>
In-Reply-To: <60540b203a4a707ba9f16fe77ed0cb02aa547ac9.camel@hammerspace.com>
References: <20201104161638.300324-1-trond.myklebust@hammerspace.com>
 <0A45C334-A375-47DC-BA04-F25341F263FA@redhat.com>
 <60540b203a4a707ba9f16fe77ed0cb02aa547ac9.camel@hammerspace.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 7 Nov 2020, at 9:23, Trond Myklebust wrote:

> On Sat, 2020-11-07 at 07:49 -0500, Benjamin Coddington wrote:
>> On 4 Nov 2020, at 11:16, trondmy@gmail.com wrote:
>>
>>> From: Trond Myklebust <trond.myklebust@hammerspace.com>
>>>
>>> The following patch series performs a number of cleanups on the
>>> readdir
>>> code.
>>> It also adds support for 1MB readdir RPC calls on-the-wire, and
>>> modifies
>>> the caching code to ensure that we cache the entire contents of
>>> that
>>> 1MB call (instead of discarding the data that doesn't fit into a
>>> single
>>> page).
>>>
>>> v2: Fix the handling of the NFSv3/v4 directory verifier
>>> v3: Optimise searching when the readdir cookies are seen to be
>>> ordered
>>
>> Hi Trond, thanks for these.
>>
>> I did a bit of testing with these on 4-core/4G client listing 1.5M
>> files
>> with READDIR.  I compared v5.10-rc2 without/with this set.
>>
>> +------+     v5.10.rc-2      +--+ this v3 patch set  +
>>> run  |  time   | rpc calls |  |  time  | rpc calls |
>>
>> nfsv3 with dtsize 262144:
>> +------+---------+-----------+--+--------+-----------+
>>> 1    | 81.583  | 14710     |  | 53.568 | 215       |
>>> 2    | 81.147  | 14710     |  | 50.781 | 215       |
>>> 3    | 81.61   | 14710     |  | 50.514 | 215       |
>>> 4    | 82.405  | 14710     |  | 50.746 | 215       |
>>> 5    | 82.066  | 14710     |  | 50.397 | 215       |
>>> 6    | 82.395  | 14710     |  | 50.892 | 215       |
>>> 7    | 81.657  | 14710     |  | 50.882 | 215       |
>>> 8    | 81.555  | 14710     |  | 50.981 | 215       |
>>> 9    | 81.421  | 14710     |  | 50.558 | 215       |
>>> 10   | 81.472  | 14710     |  | 50.588 | 215       |
>>
>> nfsv3 with dtsize 1048576:
>> +------+---------+-----------+--+--------+-----------+
>>> 1    | 81.563  | 14710     |  | 52.692 | 61        |
>>> 2    | 82.123  | 14710     |  | 49.934 | 61        |
>>> 3    | 81.714  | 14710     |  | 50.158 | 61        |
>>> 4    | 81.707  | 14710     |  | 50.083 | 61        |
>>> 5    | 81.44   | 14710     |  | 50.045 | 61        |
>>> 6    | 81.685  | 14710     |  | 50.021 | 61        |
>>> 7    | 81.17   | 14710     |  | 50.131 | 61        |
>>> 8    | 81.366  | 14710     |  | 49.928 | 61        |
>>> 9    | 81.067  | 14710     |  | 50.081 | 61        |
>>> 10   | 81.524  | 14710     |  | 50.442 | 61        |
>>
>> nfsv4 with dtsize 32768:
>> +------+---------+-----------+--+--------+-----------+
>>> 1    | 99.534  | 14712     |  | 79.461 | 331       |
>>> 2    | 98.998  | 14712     |  | 79.338 | 331       |
>>> 3    | 99.462  | 14712     |  | 81.101 | 331       |
>>> 4    | 99.891  | 14712     |  | 78.888 | 331       |
>>> 5    | 99.516  | 14712     |  | 81.147 | 331       |
>>> 6    | 98.649  | 14712     |  | 83.084 | 331       |
>>> 7    | 101.159 | 14712     |  | 80.461 | 331       |
>>> 8    | 100.402 | 14712     |  | 79.003 | 331       |
>>> 9    | 98.548  | 14712     |  | 80.619 | 331       |
>>> 10   | 97.456  | 14712     |  | 81.317 | 331       |
>>
>> nfsv4 with dtsize 1048576:
>> +------+---------+-----------+--+--------+-----------+
>>> 1    | 100.357 | 14712     |  | 78.976 | 91        |
>>> 2    | 99.61   | 14712     |  | 79.328 | 91        |
>>> 3    | 101.095 | 14712     |  | 80.649 | 91        |
>>> 4    | 107.904 | 14712     |  | 78.285 | 91        |
>>> 5    | 103.665 | 14712     |  | 79.258 | 91        |
>>> 6    | 98.877  | 14712     |  | 78.817 | 91        |
>>> 7    | 99.567  | 14712     |  | 81.11  | 91        |
>>> 8    | 99.096  | 14712     |  | 80.296 | 91        |
>>> 9    | 100.124 | 14712     |  | 78.865 | 91        |
>>> 10   | 100.603 | 14712     |  | 79.143 | 91        |
>>
>> These look great.  Feel free to add either/both of my:
>> Reviewed-by: Benjamin Coddington <bcodding@redhat.com>
>> Tested-by: Benjamin Coddington <bcodding@redhat.com>
>
> Thanks again for testing! I missed this email before sending out v4,
> but since that only adds 2 new patches to the series to deal with
> Dave's v. large changing directory case, I assume I can apply the above
> tags to the rest anyway as they have not changed?

Yes, I'll check those out too.

Ben

