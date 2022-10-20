Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A89260632A
	for <lists+linux-nfs@lfdr.de>; Thu, 20 Oct 2022 16:34:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbiJTOd6 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 20 Oct 2022 10:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbiJTOd4 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 20 Oct 2022 10:33:56 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76F0915D093
        for <linux-nfs@vger.kernel.org>; Thu, 20 Oct 2022 07:33:55 -0700 (PDT)
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id E0B043F56D
        for <linux-nfs@vger.kernel.org>; Thu, 20 Oct 2022 14:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1666276433;
        bh=5o5pD45y32AbelgLP8vxzmETh5Mbe8IIWR8fIUkt/dY=;
        h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type;
        b=u+5ZSZq26LFa1vpY12TfOjrWjW534snO4CV9aVGV2VVmRWTh76sXmi8PPcR0oePtk
         Vinepq0PwRMMAW3Wy88VSX8Q9W8GVLiuiNlnHiHKBT9Ghg+NxawT2tAkwg/Lx3F60S
         kV75KvBZXrcujub3Cnwo0e5UdQY7hxOTmOeICMR8WjOpIRMrnOXBLLpyNPq8z06CEb
         uURQoeV4RNb5kt1KspuAfQ10/9n7VmwKWEGa+mx5N98SojZ33X2JnnKTD2Ln/PxzLw
         fdYpL6xZGUD9XM7naUAIZ1nZgyLTCIAlHHxHgNWgMAKm2YpwkqpGzRTYaLBZxERG7W
         h4B1F/2FMU0pg==
Received: by mail-ed1-f70.google.com with SMTP id h13-20020a056402280d00b0045cb282161cso16424373ede.8
        for <linux-nfs@vger.kernel.org>; Thu, 20 Oct 2022 07:33:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5o5pD45y32AbelgLP8vxzmETh5Mbe8IIWR8fIUkt/dY=;
        b=uFxCJD7VjaIrRDSwj8vRJmqgM8X/Rbpw+iL0nW4h12dztHwGl1fOXmopZRqHHiCx5y
         kIOga79MiexpIumY8OCKezVMtXqarj2V93+qxjDIHddLe/Az2E9vGqbRZX+NyfDq7In3
         E3oJ3MmwYMieLxnd+wDfHNXLvxMYXP+cKyNaGUKmxn0WMsu0CyNYPKc0YvaIZ5gEF2zk
         ZSKiDFh2vnqAiLkwK6EyqDlUA8VO4M31tNH9ROoGQjhQRfADb8krPgME0X13/dNm6rKt
         vsm7sh/wvyJPP/mdNDNRw+QjHnoS9+A1dth1mdWh3mxROmoEpmiZOTe840UIrmmsGgXw
         x2Vw==
X-Gm-Message-State: ACrzQf0deuIrpGjXTXbLJ+wylbMsg+YhyeEOqkZ+ldBzxq37XtHRyS6o
        zFe2COEXuy3+r/GdDMSnYr81ZFhZ6Sc/q/H9ECo7u7bO6cD4BnzkwDjjVOzqms6k+Nqn16sK71d
        3uncMCNZAwDQvlleI4AFv4FHg9z7K2usKij+SQQ9eqEZNi7t55Xv4pA==
X-Received: by 2002:a05:6402:5ca:b0:43b:6e01:482c with SMTP id n10-20020a05640205ca00b0043b6e01482cmr12762617edx.189.1666276433648;
        Thu, 20 Oct 2022 07:33:53 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM5EwHX8OcEqAp4Nn5EwSoXebpVhkfEYY1X+02trYhy5NBEm6QZ7ve11jsac3jXebRD1E1M4xqPCuuszvqHQz40=
X-Received: by 2002:a05:6402:5ca:b0:43b:6e01:482c with SMTP id
 n10-20020a05640205ca00b0043b6e01482cmr12762606edx.189.1666276433455; Thu, 20
 Oct 2022 07:33:53 -0700 (PDT)
MIME-Version: 1.0
From:   Andreas Hasenack <andreas@canonical.com>
Date:   Thu, 20 Oct 2022 11:33:42 -0300
Message-ID: <CANYNYEG=utJ2pe+FtMWh8O+dz63R2wbzOC7ZVrvoqD=U04WL5g@mail.gmail.com>
Subject: Invalid free() in blkmapd, core dump
To:     linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

this was brought up before in
https://www.spinics.net/lists/linux-nfs/msg87598.html

We recently got bug reports about the same issue, and it was only
yesterday that I finally managed to reproduce it in a VM.

My reproduction steps are:
- add a scsi device to a vm (not virtio). Maybe works with sata too,
but scsi reproduced it
- add it to an LVM VG, and create an LV
- run blkmapd -f:
# blkmapd -f
blkmapd: open pipe file /run/rpc_pipefs/nfs/blocklayout failed: No
such file or directory
double free or corruption (out)
Aborted (core dumped)

The "No such file or directory" has nothing to do with it. You can
"modprobe blocklayoutdriver" to get rid of it, but the invalid free()
still happens.

in 2.6.1, gdb shows:
#9  0x00005555555571e5 in bl_add_disk (filepath=0x7fffffffd480
"/dev/dm-2") at device-discovery.c:232
232 free(serial->data);
(gdb) l
227 disk->dev = dev;
228 disk->size = size;
229 disk->valid_path = path;
230 }
231 if (serial) {
232 free(serial->data);
233 free(serial);
234 }
235 }
236 return;

As lixiaokeng said in that first post, this should be just
free(serial). Or use bl_free_scsi_string(), like his suggested patch
does.
