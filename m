Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1C9121778
	for <lists+linux-nfs@lfdr.de>; Mon, 16 Dec 2019 19:36:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727968AbfLPSg0 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 16 Dec 2019 13:36:26 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:37893 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729173AbfLPSgZ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 16 Dec 2019 13:36:25 -0500
Received: by mail-wr1-f48.google.com with SMTP id y17so8549802wrh.5;
        Mon, 16 Dec 2019 10:36:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=n2qqlU8y47E11EtZZTk3mdHYschbNhKlAx4Tv92JWbw=;
        b=WJc4xur6U3glMB60pMU4XO9v+245vNsJytGPjYbg0LwblPPkJa1HSeemsmLFiFcpCn
         LAcyh1ukqB7WKa1n4vl8sE2Ya4GaKFSabh5rx+Xsk7GjtE+msa3BVGMb0uqPsqHOsDvS
         q6r9553ITNyW0GTqZ+d8/3ay/tBmKMSso2HbWCgsWpNJTdNJREXLnGQFl7L+LgzsUFgn
         10RZn2z+/Cg9/MTMV9rE0OhMF53lCryofs7Eg+2oZrDU21Vt3BC1cdNU/WWv3SgmWmgd
         j202Sy/DO/vXTuIOT++IQ75saKOlxobMplE1P2VBAQwKlJ8OkzWi8dr3rnXprzlPkSgL
         H3mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=n2qqlU8y47E11EtZZTk3mdHYschbNhKlAx4Tv92JWbw=;
        b=qMHnKgNV1HoFjvxKaPLcetx8B8tKqFn6jVAn01xi7F23cU67rZMWqndiIY+3PAOjnN
         +oofNHpjphW1FfOW7uWffQMzyPq2/3P47M6yxO2QLYO0t0HTSWFi6B2enl6L75cWR9jW
         5lCsKP+O0P+NCrBbRmyFoq6VldzVM6PHYVVQT4hR++P+3tTLzjqBbr1iK61iTHjCbXk+
         EWLEBvMpuiQrOVfwGRHiNwZj8dqsIIRHWUxUtR4NV1IJftmN1lRmV13RDdabfmms9FRP
         0NoEdU6FeRcmLnZ2wRidT3KNy/s3YQvyob7X6vNIPWaJCpvX1ING4cHxsGpQ2GcFAGdR
         Zhvw==
X-Gm-Message-State: APjAAAUFgahkqN0Zb6439+8P+BIiXXCgAlXX8JdSkqTd3/jqLjrYv1aq
        bSL44XsYECqeBEbpTP8Eoqk=
X-Google-Smtp-Source: APXvYqyJvxNWgk08b47ovHhUu1IK6g2hbNz1Tr/JugUMGcQRPeifWcr/kX2LSUSLw3+7+9D2S76wfg==
X-Received: by 2002:adf:93c6:: with SMTP id 64mr30320970wrp.212.1576521384254;
        Mon, 16 Dec 2019 10:36:24 -0800 (PST)
Received: from WINDOWSSS5SP16 (cpc96954-walt26-2-0-cust383.13-2.cable.virginm.net. [82.31.89.128])
        by smtp.gmail.com with ESMTPSA id o7sm260635wmh.11.2019.12.16.10.36.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Dec 2019 10:36:23 -0800 (PST)
From:   "Robert Milkowski" <rmilkowski@gmail.com>
To:     <linux-nfs@vger.kernel.org>
Cc:     "'Trond Myklebust'" <trond.myklebust@hammerspace.com>,
        "'Anna Schumaker'" <anna.schumaker@netapp.com>,
        <linux-kernel@vger.kernel.org>, <linux-nfs@vger.kernel.org>
References: <056501d5b437$91f1c6c0$b5d55440$@gmail.com>
In-Reply-To: <056501d5b437$91f1c6c0$b5d55440$@gmail.com>
Subject: RE: [PATCH] NFSv4: nfs4_do_fsinfo() should not do implicit lease renewals
Date:   Mon, 16 Dec 2019 18:36:23 -0000
Message-ID: <05cd01d5b43f$b7d88f60$2789ae20$@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIkbnQjyymuSgNjdVHy4DQRhOG+0qcfnHIA
Content-Language: en-gb
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Hi,

If a sub-filesystem (nfsv4 mirror mount) gets unmounted and then mounted
again (by accessing it) the nfs4_do_fsinfo() function is called,
which currently assumes implicit lease renewal. I believe this is no
compliant with the RFC.

I've managed to trigger the issue by two different methods:

1) in prod

If there is an NFSv4 filesystem mounted with sub-mounts (similar setup as
below), after nfs_mountpoint_expiry_timeout of inactivity, 
Each submount will be unmounted. If now it gets accessed again it will be
automatically mounted again which will result currently
in implicit lease renewal on the client side which in turn can result in a
relatively small window where the client thinks its lease
is still valid while an nfs server has already expired the lease.

2) manual unmount

# cat /etc/exports
/ *(rw,sync)
/var *(rw,sync)


On a Linux NFS client:

# mount -o vers=4 10.50.2.59:/ /mnt/3
$ head /mnt/3/var/log/vmware-vmsvc.log >/dev/null
$ df -h | tail -2
10.50.2.59:/                                                  29G   25G
2.3G  92% /mnt/3
10.50.2.59:/var                                               20G  2.2G
16G  13% /mnt/3/var

# while [ 1 ]; do date; umount /mnt/3/var; ls /mnt/3/var >/dev/null; sleep
10; done
...

By constantly unmounting the sub-filesystem (/var) and then accessing it so
it gets mounted again (which triggers the nfs4_do_fsinfo()),
the cl_last_renewal is set to now on the client which prevents RENEW
operations from being send, and eventually the NFS server
will expire the lease (common defaults are 60s on Linux and 90s on Solaris
servers).

In testing I confirmed that both Linux and Solaris NFSv4 servers will not do
an implicit lease renewal in this case
(nfs4_do_fsinfo() results in GETATTR operations being send), in which case
the lease might expire and both Linux and Solaris
NFS servers will return NFS4ERR_EXPIRED.

The error is not handled correctly either and will result in EIO propagated
to an application issuing open().
See my other email with subject: [PATCH] NFSv4: open() should try lease
recovery on NFS4ERR_EXPIRED
which contains a fix for the NFS4ERR_EXPIRED handling.

This patch however fixes the issue with implicit lease renewal by not
setting the cl_last_renewal to now,
unless there is no lease set yet.

This was tested with 5.5.0-rc2 and the provided patch is applied on top of
the 5.5.0-rc2 as well.


btw: Recent ONTAP versions return NFS4ERR_STALE_CLIENTID which is handled
correctly - Linux client will try to renew its lease and if successful it
will retry open().
     


Best regards,
 Robert Milkowski


