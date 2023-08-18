Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C27E781472
	for <lists+linux-nfs@lfdr.de>; Fri, 18 Aug 2023 22:52:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232544AbjHRUwA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 18 Aug 2023 16:52:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240720AbjHRUvm (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 18 Aug 2023 16:51:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A55D30C2
        for <linux-nfs@vger.kernel.org>; Fri, 18 Aug 2023 13:51:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692391859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=OKbZmpgXEd4MBm0jEoSVKISNpdZ3aRryfzMNodK2EPg=;
        b=ayfpji4HUmjVSLRHjUR9/kbvBB0tsoTwKFD677ztC4QGFHr07x1QYRy85vA/8wodM+ON5x
        w/deuB8ntZSgdDOSgfwnXJTAZEyXkYTm/rzoNkBnUSbKmea86TnR3PGyYxDzL3z73cKc5O
        Urg5MU2hDid570eyuXk0mqSOcwHu0IU=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-9BaEP84QMoGgGvkEGhs4NA-1; Fri, 18 Aug 2023 16:50:58 -0400
X-MC-Unique: 9BaEP84QMoGgGvkEGhs4NA-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-637948b24bdso3387766d6.1
        for <linux-nfs@vger.kernel.org>; Fri, 18 Aug 2023 13:50:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692391858; x=1692996658;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OKbZmpgXEd4MBm0jEoSVKISNpdZ3aRryfzMNodK2EPg=;
        b=ckeMA34YBy/U8lfni3HIIeFkKMkLQHUNJHhIbh9Mu90I60WykckbfEnph6QT6v1h1n
         1C+eDP2iaQs9weKl1GjPI2/hzztPoK5v/QIaydlC/X2nAN3csictPhwimzNrRK8qCqtu
         Qzp4RPyseE0DJRDqHKUglvI9ZaCdSKiBqkzzNQwzcKQJCxohhxoySU4tuHkjxMCsFeaI
         6v70/34O9QyzZOyPAzXFoX6tEAHaAO/sOc0TRGgpB1khrpiAveNOVgHoXGn3lm9tBzwe
         V0DOD0Sg1lQxTX1lEDq5wxa9xj3+tnoEO8WBZA1koMC0NdtSLSztF6SDLbxMoBHS82NP
         Hj2A==
X-Gm-Message-State: AOJu0YxQy6CQXFOz4vA43TZ4Pg3xGO0MpGB4EY4m63WIAfkpxmiL5At/
        1Q4s/WJqPhI5R2dhtxTngLvzv55olwT/Ar3bk5du2fbcG1TgbxeFOOuOJBNhl11K4YWS8umCkA8
        UMWGiXIAztOiZu+rX93i5
X-Received: by 2002:a05:6214:4111:b0:63f:89d3:bef6 with SMTP id kc17-20020a056214411100b0063f89d3bef6mr331112qvb.6.1692391857873;
        Fri, 18 Aug 2023 13:50:57 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWdZxCQC12JlPZUWaf5pP7pHeJKEKqpqxx7Udly0ZUvD2gQuc+1wY8xdFXXefqbCjYOP/3IQ==
X-Received: by 2002:a05:6214:4111:b0:63f:89d3:bef6 with SMTP id kc17-20020a056214411100b0063f89d3bef6mr331101qvb.6.1692391857627;
        Fri, 18 Aug 2023 13:50:57 -0700 (PDT)
Received: from [172.31.1.12] ([70.109.135.191])
        by smtp.gmail.com with ESMTPSA id w2-20020a0cb542000000b00647248b3615sm950365qvd.4.2023.08.18.13.50.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Aug 2023 13:50:57 -0700 (PDT)
Message-ID: <85232631-be2a-8536-95ba-0d40cb66b53b@redhat.com>
Date:   Fri, 18 Aug 2023 16:50:56 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Steve Dickson <steved@redhat.com>
Subject: Oct 2023 Bakeathon in Westford, Ma
To:     NFSv4 <nfsv4@ietf.org>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Red Hat is pleased to announce that it is hosting the an NFSv4
Bakeathon Oct 09-13 at our Westford, MA office as well as
remote access...

Details and registration info are here:

http://www.nfsv4bat.org/Events/2023/Oct/BAT/index.html

I have rooms blocked of at two different hotels
Hampton Inn and Residence Inn Details are on again
on the the BAT website,

When registering please replying to
bakeathon-contact@googlegroups.com supplying
    * Company Name
    * How engineers are coming

I hope to see you in October!!!

steved.

