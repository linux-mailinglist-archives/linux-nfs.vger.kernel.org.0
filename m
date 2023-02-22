Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C05469FC69
	for <lists+linux-nfs@lfdr.de>; Wed, 22 Feb 2023 20:44:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231304AbjBVTow (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 22 Feb 2023 14:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230280AbjBVTov (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 22 Feb 2023 14:44:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A1B2449D
        for <linux-nfs@vger.kernel.org>; Wed, 22 Feb 2023 11:43:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1677095026;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ngMkxVyT6et1MuNNLWexnU9hQeCXToXodTJ0mFjyzDY=;
        b=JtZxUro1JIonFT6Tf863ZLu53txpDMvfi0Wl9GbiWHReADqSaXDlx1qCa/jqosaUO/dR0f
        3CSwBZ9O6RmN1mLITiwVaaT4VI6tTTjTSv9tIDEx0u34Zuc9YRPT/G7RfGKzp7qkTsaYM0
        rX/MkzrNsRgSnEZc9zCqBQ12pEdY58U=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-284-7hDcMXT1MHyn5Bnbg-QVPw-1; Wed, 22 Feb 2023 14:43:40 -0500
X-MC-Unique: 7hDcMXT1MHyn5Bnbg-QVPw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 71F661C0896F;
        Wed, 22 Feb 2023 19:43:38 +0000 (UTC)
Received: from [172.16.176.1] (unknown [10.22.50.5])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BB541440DD;
        Wed, 22 Feb 2023 19:43:37 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     =?utf-8?q?Florian_M=C3=B6ller?= 
        <fmoeller@mathematik.uni-wuerzburg.de>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Andreas Seeg <andreas.seeg@mathematik.uni-wuerzburg.de>
Subject: Re: Reoccurring 5 second delays during NFS calls
Date:   Wed, 22 Feb 2023 14:43:34 -0500
Message-ID: <90503D13-F731-49E7-B9F9-6722E9A200AC@redhat.com>
In-Reply-To: <550d9137-8d59-5be1-23be-34c6e1dff99a@mathematik.uni-wuerzburg.de>
References: <59682160-a246-395a-9486-9bbf11686740@mathematik.uni-wuerzburg.de>
 <8a02c86882bc47c1c1387dba8c7d756237cb3f3f.camel@kernel.org>
 <3b6c9b8e-2795-74e8-aefa-d4f1ac007c3c@mathematik.uni-wuerzburg.de>
 <785052D6-E39F-40D3-8BA3-72D3940EDD84@redhat.com>
 <7c7de5f1-fb6a-e970-99a2-4880583d8f6d@mathematik.uni-wuerzburg.de>
 <1B586C15-908C-4B00-9739-9AD118F88BD4@redhat.com>
 <4f70c2f5-dfdb-c37c-8663-5f2a108e229e@mathematik.uni-wuerzburg.de>
 <5AB8B0FE-5D7E-4ED4-9537-979341C6371A@redhat.com>
 <90861fe9716ab35f52b136f533ac693eb3d86279.camel@kernel.org>
 <550d9137-8d59-5be1-23be-34c6e1dff99a@mathematik.uni-wuerzburg.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 22 Feb 2023, at 7:48, Florian M=C3=B6ller wrote:

> Am 22.02.23 um 13:22 schrieb Jeff Layton:
>> On Wed, 2023-02-22 at 06:54 -0500, Benjamin Coddington wrote:
>>> On 22 Feb 2023, at 3:19, Florian M=C3=B6ller wrote:
>>>
>>>> Am 21.02.23 um 19:58 schrieb Benjamin Coddington:
>>>>> On 21 Feb 2023, at 11:52, Florian M=C3=B6ller wrote:
>>>>>
>>>>>> Hi Benjamin,
>>>>>>
>>>>>> here are the trace and a listing of the corresponding network pack=
ages. If the listing is not detailed enough, I can send you a full packag=
e dump tomorrow.
>>>>>>
>>>>>> The command I used was
>>>>>>
>>>>>> touch test.txt && sleep 2 && touch test.txt
>>>>>>
>>>>>> test.txt did not exist previously. So you have an example of a tou=
ch without and with delay.
>>>>>
>>>>> Thanks!  These are great - I can see from them that the client is i=
ndeed
>>>>> waiting in the stateid update mechanism because the server has retu=
rned
>>>>> NFS4ERR_STALE to the client's first CLOSE.
>>>>>
>>>>> That is unusual.  The server is signaling that the open file's stat=
eid is old,
>>>>> so I am interested to see if the first CLOSE is sent with the state=
id's
>>>>> sequence that was returned from the server.  I could probably see t=
his if I
>>>>> had the server-side tracepoint data.
>>>>
>>>> Hi Benjamin,
>>>>
>>>> the server-side tracepoints
>>>>
>>>> nfsd:nfsd_preprocess
>>>> sunrpc:svc_process
>>>>
>>>> were enabled. It seems they did not produce any output.
>>>>
>>>> What I did now was:
>>>> - enable all nfsd tracepoints,
>>>> - enable all nfs4 tracepoints,
>>>> - enable all sunrpc tracepoints.
>>>>
>>>> The command I used was
>>>>
>>>> touch somefile && sleep 2 && touch somefile.
>>>>
>>>> Then I unmounted the NFS share - this also causes a delay.
>>>>
>>>> I changed the security type to krb5 and captured trace and network o=
utput for a version 4.0 and a version 4.2 mount. The delay does not occur=
 when using version 4.0.
>>>
>>>
>>> In frame 9 of nfs-v4.2-krb5.pcap, the server responds to PUTFH with
>>> NFS4ERR_STALE, so nothing to do with the open stateid sequencing.  I =
also
>>> see:
>>>
>>> nfsd-1693    [000] .....  1951.353889: nfsd_exp_find_key: fsid=3D1::{=
0x0,0xe5fcf0,0xffffc900,0x811e87a3,0xffffffff,0xe5fd00} domain=3Dgss/krb5=
i status=3D-2
>>> nfsd-1693    [000] .....  1951.353889: nfsd_set_fh_dentry_badexport: =
xid=3D0xe1511810 fh_hash=3D0x3f9e713a status=3D-2
>>> nfsd-1693    [000] .....  1951.353890: nfsd_compound_status: op=3D2/4=
 OP_PUTFH status=3D70
>>>
>>
>> This just means that the kernel called into the "cache" infrastructure=

>> to find an export entry, and there wasn't one.
>>
>>
>> Looking back at the original email here, I'd say this is expected sinc=
e
>> the export wasn't set up for krb5i.
>>
>> Output of exportfs -v:
>> /export
>> gss/krb5p(async,wdelay,hide,crossmnt,no_subtree_check,fsid=3D0,sec=3Ds=
ys,rw,secure,root_squash,no_all_squash)
>> /export
>> gss/krb5(async,wdelay,hide,crossmnt,no_subtree_check,fsid=3D0,sec=3Dsy=
s,rw,secure,root_squash,no_all_squash)
>
> I changed the export definitions to
>
> /export gss/krb5(async,wdelay,hide,crossmnt,no_subtree_check,fsid=3D0,s=
ec=3Dsys,rw,secure,root_squash,no_all_squash)
> /export gss/krb5i(async,wdelay,hide,crossmnt,no_subtree_check,fsid=3D0,=
sec=3Dsys,rw,secure,root_squash,no_all_squash)
> /export gss/krb5p(async,wdelay,hide,crossmnt,no_subtree_check,fsid=3D0,=
sec=3Dsys,rw,secure,root_squash,no_all_squash)
>
> such that all three kerberos security types are exported. With this set=
up the delay is gone. Without the krb5i export the delay occurs again.
> Mounting the NFS share with different kerberos security types does not =
change this behaviour - without the krb5i export there is a delay.

After getting the ol' KDC back in shape and trying to reproduce this, I
noticed you're using a client specifier that's been deprecated (the
gss/krb5), along with sec=3Dsys in the same line.  That's a little weird,=
 not
sure what the results of that might be.

I can't even get any mount to work with that:

[root@fedora ~]# exportfs -v
/exports      	gss/krb5(sync,wdelay,hide,no_subtree_check,nordirplus,fsid=
=3D0,sec=3Dsys,rw,insecure,no_root_squash,no_all_squash)
/exports      	gss/krb5p(sync,wdelay,hide,no_subtree_check,nordirplus,fsi=
d=3D0,sec=3Dsys,rw,insecure,no_root_squash,no_all_squash)
[root@fedora ~]# mount -t nfs -ov4.1,sec=3Dkrb5 fedora.fh.bcodding.com:/e=
xports /mnt/fedora
mount.nfs: mounting fedora.fh.bcodding.com:/exports failed, reason given =
by server: No such file or directory

However, if I use the "sec=3D" method, everything seems to work fine:

[root@fedora ~]# exportfs -v
/exports      	10.0.1.0/24(sync,wdelay,hide,no_subtree_check,nordirplus,s=
ec=3Dsys:krb5:krb5p,rw,insecure,no_root_squash,no_all_squash)
[root@fedora ~]# mount -t nfs -ov4.1,sec=3Dkrb5 fedora.fh.bcodding.com:/e=
xports /mnt/fedora
[root@fedora ~]# touch /mnt/fedora/krbfoo
[root@fedora ~]# touch /mnt/fedora/krbfoo
[root@fedora ~]# umount /mnt/fedora
[root@fedora ~]# mount -t nfs -ov4.1,sec=3Dkrb5p fedora.fh.bcodding.com:/=
exports /mnt/fedora
[root@fedora ~]# touch /mnt/fedora/krbfoo
[root@fedora ~]# touch /mnt/fedora/krbfoo
[root@fedora ~]# umount /mnt/fedora

=2E. so I can't seem to reproduce this because I can't even mount.  Did y=
ou
perhaps have a previous mount with that client with a different security
flavor?

I think your NFS client ended up having a machine credential with krb5i, =
but
then the export with that flavor was removed.  When the client tried to d=
o a
CLOSE, it picked the machine cred, which caused the server to fail in the=

lookup of the export, which caused the client to think its stateid was
wrong.

Ben

