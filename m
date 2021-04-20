Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E013366147
	for <lists+linux-nfs@lfdr.de>; Tue, 20 Apr 2021 22:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233896AbhDTU7x (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 20 Apr 2021 16:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233769AbhDTU7x (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 20 Apr 2021 16:59:53 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F327C06174A
        for <linux-nfs@vger.kernel.org>; Tue, 20 Apr 2021 13:59:20 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id w4so35403508wrt.5
        for <linux-nfs@vger.kernel.org>; Tue, 20 Apr 2021 13:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=vastdata.com; s=google;
        h=to:from:subject:message-id:date:user-agent:mime-version
         :content-transfer-encoding:content-language;
        bh=Hpq4iSxAXoLqZJNuVVl40Zg66FmO183P/QMcuCSoF1w=;
        b=SCRtuiHihKfdkT/kxpKRNY6B4bnU1gzPLUDhFTRloTm3OoOtUxW06zxJQOyczkxHpx
         LEJRuz6HCMafzK9Ku/LXVM47yxwhe0qNkUlH3+boou+bAr0DKJAzFlCYmS80veswUOzM
         t3/jxKXl9u7MbUCfb82IO3r9sBjbvB0AwwdO0qo/IecnfntiGYDCxllejbwfhdTuEijK
         5MENWTgWuTcWAID1jYllOeA+XZaYPm5buoXaP1HW9bjmXh0zqjUanIKKa30yoibXpy8R
         ffdFtf7KsG9BdM703mBlFMqbe1ImnSZFz01H4eoMgcSXDHoHOpkjdt49IL+J+3Re8dY0
         9glg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:from:subject:message-id:date:user-agent
         :mime-version:content-transfer-encoding:content-language;
        bh=Hpq4iSxAXoLqZJNuVVl40Zg66FmO183P/QMcuCSoF1w=;
        b=DVXAzSBFNCeCx6Pz6EOMJQlV9W7qTWmSBeXHspPLSrQnDE73J0zaRc6eVu+VBfYArV
         mNoOLzx+G0DjfH9nkRB90zTT9XL8JvzhqqjcaPvI6AeKnysdXGW6vTsz8mTaZ0VoxFkE
         xN/mHgblNPp0sYVpn/y8eouXokH6D2vu/ccl1g70bMt+pB2Cb9mawQYVCb4qt+l2HaI7
         3UIsfz6EXWSEKGWulZ6UHLzUIAlICoSyCj8PtMJ3D/kbmoW+Tzg9WBSFLvuDrqOnjqqb
         G3Fs0hrvweAQtNt7B0gHDB18pZejFlxODCbRIqLsgvQSBBZ36IIqL5Fphg8vc0btzskx
         KoJQ==
X-Gm-Message-State: AOAM531vxt3zecKoomAKegTv0oBRR1K1KEdE9Q5ltAPM3jtU3IYVhatW
        U7+sd16PUcxK73j7vohGZ/sGR2QrCKKELQ==
X-Google-Smtp-Source: ABdhPJw4Og4z4I8uf3M5nZR6UR41FoQN/OibzruZQJ3Bd9QktDZN3qcpV2H80mtOcT3/JGQW0L72eg==
X-Received: by 2002:adf:fc85:: with SMTP id g5mr22479646wrr.119.1618952358657;
        Tue, 20 Apr 2021 13:59:18 -0700 (PDT)
Received: from [192.168.0.102] (line103-230.adsl.actcom.co.il. [192.117.103.230])
        by smtp.gmail.com with ESMTPSA id y15sm238722wrh.8.2021.04.20.13.59.17
        for <linux-nfs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Apr 2021 13:59:18 -0700 (PDT)
To:     linux-nfs@vger.kernel.org
From:   guy keren <guy@vastdata.com>
Subject: Linux NFS4.1 client's "server trunking" seems to do the opposite of
 what the name implies
Message-ID: <061a976c-2082-bb86-91ec-f0f97a73e1ac@vastdata.com>
Date:   Tue, 20 Apr 2021 23:59:16 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org


Hi,

when attempting to make two NFS 4.1 mounts from a linux NFS client, to 
two IP addresses belonging to two different hosts in the same cluster 
(i.e. the server major id in the EXCHANGE_ID response is the same) - the 
linux NFS4.1 client discards the new TCP connection (to the 2nd IP) and 
instead decides to use the first client connection for both mounts. this 
seems to be handled in a hard-coded inside the function named 
"nfs41_discover_server_trunking", and leads to reduced performance, 
relative to using NFS3 (which will use two different TCP connections to 
the two different hosts in the storage cluster).

i was under the impression that (client_id) trunking is supposed to 
allow to multiplex commands over multiple TCP connections - not to 
consolidate different workloads onto the same TCP connection.

is there a way to avoid this behaviour, other then faking that the 
"server major id" is different on each node in the cluster? (this is 
what appears to be done by NetApp, for instance).

thanks,

--guy keren

Vast Data.

