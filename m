Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DBFD75969E
	for <lists+linux-nfs@lfdr.de>; Wed, 19 Jul 2023 15:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjGSNZi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 19 Jul 2023 09:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjGSNZh (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 19 Jul 2023 09:25:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD1DD119
        for <linux-nfs@vger.kernel.org>; Wed, 19 Jul 2023 06:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689773089;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H+WScs5V062wBamLy/VYSwG2qEzMGnHGCJxs3puPkcM=;
        b=TEd1HrVTmPwkiiUu6MrcEVCRfJCkiaCKCG1FZaR4hsn5If34deQ3u5mfcWt7xQRQ8Fq4HK
        +sVeCL0/YCuP/Cpe+5I/y9v3j5QWt72uzO4Btvtvr+j22kyKAg5C3J/EzbM3MlpsFL51FY
        W5Ml4p8e1/DBB18n32h22ZpQz8FIU+Q=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-502-p4-rr414Pz6JgT17AE4n9w-1; Wed, 19 Jul 2023 09:24:48 -0400
X-MC-Unique: p4-rr414Pz6JgT17AE4n9w-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8279F10504B2;
        Wed, 19 Jul 2023 13:24:47 +0000 (UTC)
Received: from [192.168.37.1] (unknown [10.22.50.6])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A9D9940D2839;
        Wed, 19 Jul 2023 13:24:46 +0000 (UTC)
From:   Benjamin Coddington <bcodding@redhat.com>
To:     Kinglong Mee <kinglongmee@gmail.com>
Cc:     Anna Schumaker <anna@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>
Subject: Re: [PATCH v2] nfs: fix redundant readdir request after get eof
Date:   Wed, 19 Jul 2023 09:24:45 -0400
Message-ID: <ECE48590-218F-4304-A043-B9AEB04CD3DA@redhat.com>
In-Reply-To: <CAB6yy374gQmrAjtLmFWGDVq9GBfxFoA-L95oELo=k+W9TF7cyg@mail.gmail.com>
References: <CAB6yy374gQmrAjtLmFWGDVq9GBfxFoA-L95oELo=k+W9TF7cyg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On 18 Jul 2023, at 8:44, Kinglong Mee wrote:

> When a directory contains 17 files (except . and ..), nfs client sends
> a redundant readdir request after get eof.
>
> A simple reproduce,
> At NFS server, create a directory with 17 files under exported director=
y.
>  # mkdir test
>  # cd test
>  # for i in {0..16}  ; do touch $i; done
>
> At NFS client, no matter mounting through nfsv3 or nfsv4,
> does ls (or ll) at the created test directory.
>
> A tshark output likes following (for nfsv4),
>
>  # tshark -i eth0 tcp port 2049 -Tfields -e ip.src -e ip.dst -e nfs -e
> nfs.cookie4
>
> srcip   dstip   SEQUENCE, PUTFH, READDIR        0
> dstip   srcip   SEQUENCE PUTFH READDIR
> 909539109313539306,2108391201987888856,2305312124304486544,256633545246=
3141496,2978225129081509984,4263037479923412583,4304697173036510679,46667=
03455469210097,4759208201298769007,4776701232145978803,533840847851208126=
2,5949498658935544804,5971526429894832903,6294060338267709855,65288405662=
29532529,8600463293536422524,9223372036854775807
> srcip   dstip
> srcip   dstip   SEQUENCE, PUTFH, READDIR        9223372036854775807
> dstip   srcip   SEQUENCE PUTFH READDIR
>
> The READDIR with cookie 9223372036854775807(0x7FFFFFFFFFFFFFFF) is
> redundant.
>
> Signed-off-by: Kinglong Mee <kinglongmee@gmail.com>

Weird, I never got a copy from linux-nfs.   The plain-text version of thi=
s
is whitespace damaged, but the HTML version looks right.

Reviewed-by: Benjamin Coddington <bcodding@redhat.com>

Ben

