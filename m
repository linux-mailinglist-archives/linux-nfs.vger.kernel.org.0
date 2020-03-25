Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4957192AA9
	for <lists+linux-nfs@lfdr.de>; Wed, 25 Mar 2020 15:00:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727394AbgCYOAz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 25 Mar 2020 10:00:55 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:36498 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727406AbgCYOAz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 25 Mar 2020 10:00:55 -0400
Received: by mail-lf1-f41.google.com with SMTP id s1so1872948lfd.3
        for <linux-nfs@vger.kernel.org>; Wed, 25 Mar 2020 07:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=1X54vUFjL3fNWuhI2m7BsEWpVjrZJq+SetZ1m9FV5Ss=;
        b=m9zXf9IbjEhJS2MwF/BKnJSlNa4yydVo1FlBqAToQmha1yRxvBCqga+gi/rATE8C+3
         HZQhShAjUFGTeVyItkyN16Vbnr1HJBPfbaKUXkajxL1Ms5bMfNnGQKEk6A4yYBdur+EK
         +nwHI0rgmcjA3Gxsc6aBqbRhcv4/BzSEJdWRDXP0J3fy2x/U8Cve3GHpTY5FbWUaxBMH
         wcVmWYm6PHENjt36Huoy4aRcqDo9YFCAgA4h6dDhlEYhqmEyUCr/pIIkTaNZTmjxOEMX
         4B6o1yIE1PUZoQ+pEvaghv/NYaZ1mYV1WPjpegRH6B8STQHA3OguURRLaLljJrEmZ0hd
         94Wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=1X54vUFjL3fNWuhI2m7BsEWpVjrZJq+SetZ1m9FV5Ss=;
        b=M7gHOvAyLQcuTSTDVIUPeAGmvAN3oVXVxy8bgWqyrPn5T8boXzp5DkF146FdfCpzl8
         QNw52OyfKPIkhsCCMzCnUuQAdbBPBDgxwHGrVx8mJxNvYpXznc4+KxQ1cSJiF3r2fmGT
         js57oBDijp2D0gEbTy7LOlWaIoZ6lwRSA96KKEOJVSRgPpV0VyykPrz2Ru8TiwGqdNok
         cO64Y2zQIj6DFtspnoDMVTF8CxDCV6b5GW644wedl/QzRzC4QeUSgxx3Swd0DGwEM8vu
         ZZs/Lgb++GTiKaKwvBEGbbOS86T3vHpxXOgt6+AEOukW5eDsQBQ5918F4l7+lnJufIMX
         PF0A==
X-Gm-Message-State: ANhLgQ2z1QxwJ4/5O1q5qA5j/I0xtCIIyXqrhpa0JzTKXbLYfNL32wie
        7qm2n9UFWRa0AeA+LOI7A/btrqAVkv48bsSoDfg=
X-Google-Smtp-Source: ADFU+vt32EWiATLPtbzwBGlAK1x+3eR4BPXRrFCV2GESaFHvbei2dIPd+E7CFnJsdrxJwvwucCGf/e8HojmJv7wxs04=
X-Received: by 2002:ac2:5de7:: with SMTP id z7mr2412785lfq.174.1585144853117;
 Wed, 25 Mar 2020 07:00:53 -0700 (PDT)
MIME-Version: 1.0
References: <9932cd04adc20b73040d82c605acb0b5a24e3855.camel@hammerspace.com> <8B8B914C-D741-42E0-BC0C-4850635B5551@gmail.com>
In-Reply-To: <8B8B914C-D741-42E0-BC0C-4850635B5551@gmail.com>
From:   James Pearson <jcpearson@gmail.com>
Date:   Wed, 25 Mar 2020 14:00:42 +0000
Message-ID: <CAK3fRr_=e_JzBGPH-kWW6P8tQ-ZLhOpnFkd9kgGEmDxbHzJOhA@mail.gmail.com>
Subject: Re: Stuck NFSv4 mounts of Isilon filer with repeated
 NFS4ERR_STALE_CLIENTID errors
To:     Kevin Vasko <kvasko@gmail.com>
Cc:     "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 25 Mar 2020 at 13:20, Kevin Vasko <kvasko@gmail.com> wrote:
> James,
>
> Just curious are your symptoms anything similar to mine where if you tran=
sfer a file (200MB+) to the NFS server, the transfer will just lock up and =
never complete? Are you using Kerberos as well? If so...
>
> I had a problem on a Dell Unity box where on a transfer to the NFS server=
 the sequence number gets out of order and it would lock up the Dell Unity =
box NFS and the transfer would never complete.
>
> Dell was not aware of this bug and they had to have engineering look at t=
he issue. After about 3 months they got back with and had me change two par=
ameters.
>
> scv_nas ALL -parma -facility nfs -modify rpcgss.discardReplay -value 0
>
> scv_nas ALL -parma -facility nfs -modify rpcgss.discardOld -value 0
>
> I=E2=80=99m doubtful that this would be the same way you would change the=
se settings on the Isilon but just figured if it=E2=80=99s related it might=
 help.
> a Isilon

We're not using Kerberos, just SYS_AUTH ...

James
