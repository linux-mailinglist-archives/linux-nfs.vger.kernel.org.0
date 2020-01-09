Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B408B135C56
	for <lists+linux-nfs@lfdr.de>; Thu,  9 Jan 2020 16:10:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730025AbgAIPKL (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 9 Jan 2020 10:10:11 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40561 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729483AbgAIPKK (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 9 Jan 2020 10:10:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578582610;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ngmA26M2hKVkT6Bn1Bfh8CbRqBM+Rm+OJlQ2g5on+NM=;
        b=BEoZneG3df5fnrhbCXp6TNkPZ8cP9qzXifipadhpqh0uE1Wr4cyuCWjaqeqvKJe10f69fb
        oCARDJzkJ1MZZMyMcgbfKL5rfgFkBmWp4MrKfkbPCWXLqBjcq+Y8hm/eAlGgcdlMvfOOOQ
        D0NtCBg+JsB+7zx8z+qFpM7cLDcd5Pk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-131-y42Sqch3PfiFmH76jCj8xw-1; Thu, 09 Jan 2020 10:10:05 -0500
X-MC-Unique: y42Sqch3PfiFmH76jCj8xw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B70128018CD;
        Thu,  9 Jan 2020 15:10:04 +0000 (UTC)
Received: from madhat.boston.devel.redhat.com (madhat.boston.devel.redhat.com [10.19.60.33])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 47EE810027A9;
        Thu,  9 Jan 2020 15:10:04 +0000 (UTC)
Subject: Re: [nfs-utils PATCH 0/7] silence some warning in rpcgen
To:     Giulio Benetti <giulio.benetti@benettiengineering.com>,
        linux-nfs@vger.kernel.org
References: <20200103215039.27471-1-giulio.benetti@benettiengineering.com>
 <11af1233-d6e1-3952-475d-306dc5fefc06@RedHat.com>
 <38aa6cba-91e4-f1ec-7978-45ba4b4cf4ee@benettiengineering.com>
From:   Steve Dickson <SteveD@RedHat.com>
Message-ID: <6ba97db1-bab3-95c5-9472-bde7865b8a4c@RedHat.com>
Date:   Thu, 9 Jan 2020 10:10:03 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <38aa6cba-91e4-f1ec-7978-45ba4b4cf4ee@benettiengineering.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



On 1/9/20 9:00 AM, Giulio Benetti wrote:
> On 1/7/20 8:06 PM, Steve Dickson wrote:
>>
>>
>> On 1/3/20 4:50 PM, Giulio Benetti wrote:
>>> Since I'm trying to bump version of nfs-utils to latest in Buildroot,=
 I've
>>> noticed some warning in rpcgen, so I've decided to clean them up by f=
ixing
>>> code or #pragma ignoring them. Hope this is useful. Other warnings ar=
e
>>> still there waiting to be fixed and if you find these patches useful =
I'm
>>> going to complete all warning correction.
>>>
>>> Giulio Benetti (7):
>>> =A0=A0 rpcgen: rpc_cout: silence unused def parameter
>>> =A0=A0 rpcgen: rpc_util: add storeval args to prototype
>>> =A0=A0 rpcgen: rpc_util: add findval args to prototype
>>> =A0=A0 rpcgen: rpc_parse: add get_definition() void argument
>>> =A0=A0 rpcgen: rpc_cout: fix potential -Wformat-nonliteral warning
>>> =A0=A0 rpcgen: rpc_hout: fix potential -Wformat-security warning
>>> =A0=A0 rpcgen: rpc_hout: fix indentation on f_print() argument separa=
tor
>>>
>>> =A0 tools/rpcgen/rpc_cout.c=A0 | 8 ++++----
>>> =A0 tools/rpcgen/rpc_hout.c=A0 | 4 +++-
>>> =A0 tools/rpcgen/rpc_parse.h | 2 +-
>>> =A0 tools/rpcgen/rpc_util.h=A0 | 4 ++--
>>> =A0 4 files changed, 10 insertions(+), 8 deletions(-)
>>>
>> Committed (tag: nfs-utils-2-4-3-rc5)
>>
>> I must admit this code is actually being used... I assume they do the =
right thing...
>>
>> The rpcgen we been using is the old one that came out
>> of the glibc code at https://github.com/thkukuk/rpcsvc-proto
>>
>> I wonder what the difference is....
>=20
> I can check it and use that one as upstream maybe and update it here in=
 nfs-utils if you see that it makes sense.
That would be interest... If they both generate the same
code... two are probably not needed...=20

but I bet either code base as not changed in 40 yrs ;-)=20

steved.

>=20
> Best regards

