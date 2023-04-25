Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB3ED6EE237
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Apr 2023 14:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233516AbjDYMvR (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Apr 2023 08:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234174AbjDYMvQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Apr 2023 08:51:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125E7CC31
        for <linux-nfs@vger.kernel.org>; Tue, 25 Apr 2023 05:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1682427029;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SKkQqOCF0exAGtYHGPgR/tK/LRVO33d85C82rWX6KWE=;
        b=Q74n6dvKoBOaQx5RYQ2r5+OVu6+diZOaTiK+P97LPFq6QeMqNM2GCh4RtHEnQioXTdb0VU
        w/MoN25CDWkU6pRavOnDGPKqtN2Jt4oS4TFv2Rbft8NtMPt4kEkVmeVGdW5zSc02H9hugs
        HdVHtb6u4GrtrvdvBwfpcoRYdsMJS90=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-279-DVyAaZYMNzO4H1BM8iMcCQ-1; Tue, 25 Apr 2023 08:50:28 -0400
X-MC-Unique: DVyAaZYMNzO4H1BM8iMcCQ-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-5ef3c877a1aso2103816d6.0
        for <linux-nfs@vger.kernel.org>; Tue, 25 Apr 2023 05:50:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682427027; x=1685019027;
        h=content-transfer-encoding:in-reply-to:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SKkQqOCF0exAGtYHGPgR/tK/LRVO33d85C82rWX6KWE=;
        b=G2a/UcAnuVAUiyBpz3qkqplL2q4p2ENGZ5UDOVhRhtJkKpgvDyzgQgN6aRAAcZ17va
         iRx6ei8fXlKgTKOK9W47iODep2hsBBPW6gukMYIh94IVgARjMsyqN8L8XIAlRKWLnQsI
         a10pYV2IHcg3Z8/nvt5Yb924NXQ0LqAtaVohueoulK8mrTuAznHYuxXGFOxOpRyKMK2j
         MYmYNs4Rx/h0YvfsliiZPcSbbJXlWqvkWWIoN4fJ9e7HxVysGdy6QYQLRgcEhaooHy9V
         wqOkLWrwx90IlI02AemaFtR0taZkvadwLjYiyx0A31jifr/iJ+v1iLGYqN0GMBv/TKFN
         nFng==
X-Gm-Message-State: AAQBX9fVKRbDKBsEkifAEb2N/ijI5OGc/9yhh9ovRuuMK4Yk15SIRc+M
        Dv3Hb/Bj2a0+/HHofqE5gI/FjJeUVMs2h4o5jQQi8QL59JzKldgxJBfExK8iq16Kb2+WLh1NcQA
        lFiI+G3U1NjLUd++DFatv
X-Received: by 2002:a05:6214:5292:b0:5ad:cd4b:3765 with SMTP id kj18-20020a056214529200b005adcd4b3765mr27794479qvb.1.1682427027100;
        Tue, 25 Apr 2023 05:50:27 -0700 (PDT)
X-Google-Smtp-Source: AKy350beTmYJ3Mz0mQYM+HMBVU+1251AQkvh4O5UWndGtufIHH5k8VszVZvUCOmnflu4LGtB2/DK1A==
X-Received: by 2002:a05:6214:5292:b0:5ad:cd4b:3765 with SMTP id kj18-20020a056214529200b005adcd4b3765mr27794450qvb.1.1682427026747;
        Tue, 25 Apr 2023 05:50:26 -0700 (PDT)
Received: from [172.31.1.12] ([71.161.80.57])
        by smtp.gmail.com with ESMTPSA id d10-20020a0ce44a000000b005dd8b9345cdsm4022136qvm.101.2023.04.25.05.50.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Apr 2023 05:50:26 -0700 (PDT)
Message-ID: <bd70a831-977f-6ace-75a1-037ea895b9a2@redhat.com>
Date:   Tue, 25 Apr 2023 08:50:25 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Bakeathon Is On!
Content-Language: en-US
From:   Steve Dickson <steved@redhat.com>
To:     nfsv4@ietf.org, linux-nfs@vger.kernel.org
References: <12ec5a2c-b340-cb66-7cf9-dfa726496430@redhat.com>
In-Reply-To: <12ec5a2c-b340-cb66-7cf9-dfa726496430@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

I forgot to mention talks will be at 2pm EST [1]
for the next couple of days...

Please feel free to join in via Google chat [2]

steved.

[1] 
https://docs.google.com/spreadsheets/d/1_BWbwEBqmWGgp1zbWXOILgYTJjowRlhNichNLY_xLqs/edit#gid=1920779269
[2] https://meet.google.com/ify-afqi-wwr?authuser=0

On 4/25/23 8:44 AM, Steve Dickson wrote:
> Hey!
> 
> It started yesterday... We are doing some very good
> testing... esp with RPC-with-TLS...
> 
> Feel free to join in... the instructions are at [1]
> and are very easy...
> 
> steved.
> 
> [1] http://www.nfsv4bat.org/Events/2023/Apr/BAT/index.html

