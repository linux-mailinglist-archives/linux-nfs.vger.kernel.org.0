Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C102752CBF
	for <lists+linux-nfs@lfdr.de>; Fri, 14 Jul 2023 00:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231316AbjGMWNu (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 13 Jul 2023 18:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjGMWNt (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 13 Jul 2023 18:13:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5557211B
        for <linux-nfs@vger.kernel.org>; Thu, 13 Jul 2023 15:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689286381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L3634a4HU94uMg7auhiudiVLe/dM8LdOx7sFFmoHuDU=;
        b=fT03/OPRc+WcUAX/Gmopgdwm+ULglZOi6+OQF5T5acvE3bbai4hVuEFUKduTy84XszinvD
        5ZFll0n7173CLRZ9Vlp9pp4MoNOnW/PBJ2DtMpkZ+vBukixB7ZZxioUxITaDjB/iB9Aq+W
        Wz7NbJ3cWoE+80ivKP5/Rie9Hzc8plY=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-290-SntjwTmKMwqcD3nU3wwfAw-1; Thu, 13 Jul 2023 18:12:58 -0400
X-MC-Unique: SntjwTmKMwqcD3nU3wwfAw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 24B7728040A4;
        Thu, 13 Jul 2023 22:12:58 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.50.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 50A4F200AD6E;
        Thu, 13 Jul 2023 22:12:57 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Olga Kornievskaia <olga.kornievskaia@gmail.com>
Cc:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com,
        linux-nfs@vger.kernel.org
Subject: Re: [PATCH 1/1] NFSv4.1: fix zero value filehandle in post open
 getattr
Date:   Thu, 13 Jul 2023 18:12:56 -0400
Message-ID: <A05D90E0-6D74-4948-B948-852B1448DD3C@redhat.com>
In-Reply-To: <CAN-5tyGa1dV1A5RgZsMCQzFHDV63=LDJq0DTpg8aJ=UCO+k+Og@mail.gmail.com>
References: <20230713195416.30414-1-olga.kornievskaia@gmail.com>
 <A0663B9C-F005-4089-ABD6-542F77EE43ED@redhat.com>
 <CAN-5tyGa1dV1A5RgZsMCQzFHDV63=LDJq0DTpg8aJ=UCO+k+Og@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 13 Jul 2023, at 17:27, Olga Kornievskaia wrote:

> On Thu, Jul 13, 2023 at 5:09 PM Benjamin Coddington <bcodding@redhat.com> wrote:
>>
>> On 13 Jul 2023, at 15:54, Olga Kornievskaia wrote:
>>
>>> From: Olga Kornievskaia <kolga@netapp.com>
>>>
>>> Currently, if the OPEN compound experiencing an error and needs to
>>> get the file attributes separately, it will send a stand alone
>>> GETATTR but it would use the filehandle from the results of
>>> the OPEN compound. In case of the CLAIM_FH OPEN, nfs_openres's fh
>>> is zero value. That generate a GETATTR that's sent with a zero
>>> value filehandle, and results in the server returning an error.
>>>
>>> Instead, for the CLAIM_FH OPEN, take the filehandle that was used
>>> in the PUTFH of the OPEN compound.
>>>
>>> Signed-off-by: Olga Kornievskaia <kolga@netapp.com>
>>> ---
>>>  fs/nfs/nfs4proc.c | 6 +++++-
>>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/fs/nfs/nfs4proc.c b/fs/nfs/nfs4proc.c
>>> index 8edc610dc1d3..0b1b49f01c5b 100644
>>> --- a/fs/nfs/nfs4proc.c
>>> +++ b/fs/nfs/nfs4proc.c
>>> @@ -2703,8 +2703,12 @@ static int _nfs4_proc_open(struct nfs4_opendata *data,
>>>                       return status;
>>>       }
>>>       if (!(o_res->f_attr->valid & NFS_ATTR_FATTR)) {
>>> +             struct nfs_fh *fh = &o_res->fh;
>>> +
>>>               nfs4_sequence_free_slot(&o_res->seq_res);
>>> -             nfs4_proc_getattr(server, &o_res->fh, o_res->f_attr, NULL);
>>> +             if (o_arg->claim == NFS4_OPEN_CLAIM_FH)
>>> +                     fh = NFS_FH(d_inode(data->dentry));
>>> +             nfs4_proc_getattr(server, fh, o_res->f_attr, NULL);
>>>       }
>>>       return 0;
>>>  }
>>
>> Looks good, but why not just use o_arg->fh?  Maybe also an opportunity
>> to fix the whitespace damage a few lines before this hunk too.
>>
>
> I did try it first. I had 2 problems with it. First of o_arg->fh is a
> "const struct" so it wouldn't allow me to be assigned without casting.
> Ok so perhaps it's not a big deal that we are going against the
> "const". Second of all, when I did do that, it produced the following
> warning and so I thought perhaps I should really use the original fh
> instead of what's in the args:

Oh maybe because this is the error path and nfs4_opendata is getting cleaned
up in nfs4_open_release()?  The comments in nfs4_open_release are a bit
confusing, but I think for the cases where we need to re-use the opendata we
are doing a kref_get on it.  Maybe we need a kref_get on the opendata for
this case?

.. I suspect we'd have the o_res.fh from nfs4_opendata_get_inode().  Out of
time, will check back in tomorrow.

Ben

