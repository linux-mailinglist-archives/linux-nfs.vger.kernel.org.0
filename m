Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1F632DF882
	for <lists+linux-nfs@lfdr.de>; Mon, 21 Dec 2020 06:08:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726213AbgLUFHf (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 21 Dec 2020 00:07:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726160AbgLUFHf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 21 Dec 2020 00:07:35 -0500
Received: from mail-oi1-x229.google.com (mail-oi1-x229.google.com [IPv6:2607:f8b0:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3869C0613D3
        for <linux-nfs@vger.kernel.org>; Sun, 20 Dec 2020 21:06:54 -0800 (PST)
Received: by mail-oi1-x229.google.com with SMTP id q205so10111382oig.13
        for <linux-nfs@vger.kernel.org>; Sun, 20 Dec 2020 21:06:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=frDUp5BTlrdnyAuh9TFV+2I6TGuU5Sk1/Bmgn4Jsk9M=;
        b=uQCmbjjYDEiaeO7xrrGbZLKQFqiZPu2DoB6+7sSkegoZk9SDXA5O9YRQ7Tn/oJQuLu
         AP2+ZJTe3e3XtDj2PWqeyZg78mzfkB4VCfandCZFVgZjKpMc1lQl7g++8PId6fONiPix
         J9lQnkJS2W63WrVBbiaYVs54ZkgXVwpD/gmAJX3yj8DPzSNxjJB07v53OOt+vK7yCGrq
         Q4bLaHvWw/kA9GYUqHwew5CPjQqbcxdiyOon2epodFmWo7VXQJO1T+X0l7i7NTZjhs7L
         Y52KU22JC/btHgj/fP6cXfmHKop1wBvmcvDX1SkjgQfFhf1giCcXYDuEb33Mn3TafqFp
         OPjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=frDUp5BTlrdnyAuh9TFV+2I6TGuU5Sk1/Bmgn4Jsk9M=;
        b=thTL4ACJi4KQAVa8DK6YPqUNd6eaPe04dXlcPHbrcEaefIO43Vr1hPaJ6GZ6uGcDrz
         XN6XTbItXA84tq3mCXr8c6MSQItwW4hYT2SLUTYeoSbtxbULLwwQN23a74A8yhvOzQed
         +g15nSZNscrazeMQy187pbf96JpElFIU5udZEfNNFhPqDxmFF0SXSIO6ZZ7vgcD0KI6L
         U3t3zP4iBJM1a9rvta18sN0TB+DaaOGrRiHpvtEBeS/9K2+VS+gLMzRj0+BJa6j7s20g
         oeFzZHcIp3xhAGDM0prlTRZOMfqC8sjKAmaSI4qnzPdbaXh+ThQsSvJdOIFYTQQuBgvy
         bqjA==
X-Gm-Message-State: AOAM530Jw0lCGRidx9iR6nO6SuNom+tGWSofIDUWea26TjaSbU0zy8uX
        nypj/aRBfb0olT8iQ6M3Es9a3u+ZNNN/0g==
X-Google-Smtp-Source: ABdhPJxPel2uBq/A3GWAsqm1yPfj7KP8+HaACg45RwlvWBJtGeKM9p6dJP1pxqVyRCGpg8Wbm+mH5g==
X-Received: by 2002:a17:90a:d790:: with SMTP id z16mr15388320pju.88.1608518577576;
        Sun, 20 Dec 2020 18:42:57 -0800 (PST)
Received: from loghyr.internal.excfb.com (c-69-181-67-218.hsd1.ca.comcast.net. [69.181.67.218])
        by smtp.gmail.com with ESMTPSA id bf3sm14214278pjb.45.2020.12.20.18.42.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 20 Dec 2020 18:42:57 -0800 (PST)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.120.23.2.4\))
Subject: Re: [pynfs 03/10] Close the file for SEQ10b
From:   Thomas Haynes <loghyr@gmail.com>
In-Reply-To: <20201218164325.GD1258@fieldses.org>
Date:   Sun, 20 Dec 2020 18:42:55 -0800
Cc:     Bruce Fields <bfields@redhat.com>,
        Linux NFS Mailing list <linux-nfs@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C99E0C08-FEC2-4F5A-9467-7B96CA8E51F2@gmail.com>
References: <20201217003516.75438-1-loghyr@hammerspace.com>
 <20201217003516.75438-4-loghyr@hammerspace.com>
 <20201218164325.GD1258@fieldses.org>
To:     "J. Bruce Fields" <bfields@fieldses.org>
X-Mailer: Apple Mail (2.3608.120.23.2.4)
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Dec 18, 2020, at 8:43 AM, J. Bruce Fields <bfields@fieldses.org> =
wrote:
>=20
> On Wed, Dec 16, 2020 at 04:35:09PM -0800, Tom Haynes wrote:
>>=20
>>     close_file(sess1, fh, stateid=3Dstateid)
>>=20
>> +    # Cleanup
>> +    res =3D sess1.compound([op.putfh(fh), op.close(0, stateid)])
>> +    check(res)
>> +
>=20
> This is giving me:
>=20
> SEQ10b   st_sequence.testReplayCache007                           : =
FAILURE
>           OP_CLOSE should return NFS4_OK, instead got
> 	              NFS4ERR_BAD_STATEID
>=20
> probably because the file was already closed just above.  I'm not sure
> whta was intended here.  Reverting for now.
>=20
> =E2=80=94b

Ahh, that close is not there in the branch we have internally. And since =
git took the change, I thought it was still good.

Backing out is cool.


