Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD501BC7B2
	for <lists+linux-nfs@lfdr.de>; Tue, 28 Apr 2020 20:24:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728392AbgD1SYz (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 28 Apr 2020 14:24:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727827AbgD1SYz (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 28 Apr 2020 14:24:55 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD0C0C03C1AB
        for <linux-nfs@vger.kernel.org>; Tue, 28 Apr 2020 11:24:54 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id n17so18020255ejh.7
        for <linux-nfs@vger.kernel.org>; Tue, 28 Apr 2020 11:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umich.edu; s=google-2016-06-03;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=nnMiXqFOK/q/Db8uQpke53LKPToABJ5/fHBLiWyIV+A=;
        b=oaBhCBnbBCGXy59M8H1IhoSZ8cNXgHCWs1dcWzGilgRbolmeXxuQGffrWWufOmEcGr
         lHH8fy2y419klDAN856d1hZg20z7KIceam/zeMDotqmnrj8SirGDe0Xad3VVPjzJv6aB
         3/GY56p7mgihaN+dsky3BOjMip/8aD9PoFr5ypkU6K6hq3XOPUpkW2X/cDBXJcU0yGZ1
         7xyVTR59exAiqcAbIegRwHScm3MCnuzNExwwZeSg0jrBENXc9LX14JDsytZCqxwc5BrK
         Yy3eT3djw5FOSDTaXUjuKhoKU4QOhUHsz/TYS7lieEdLQu+LYxm/i2JUh9R+ymLU9UXa
         jpHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=nnMiXqFOK/q/Db8uQpke53LKPToABJ5/fHBLiWyIV+A=;
        b=ojuisEuZYjBNe32xf9NXoVhGeE6IjWByzppsIPZYhOuHLobq+Gdr2tYo/RFhzpr2Wn
         024I0YbJg7SgrxTfPgomdrcJqZspWzNYxuS7o3ZGvnVWLVXNruSp7meu3o2FBATlr4U/
         WQiab03HLaduMi3CETLUQIPvm48vC5mOqbfoslx6X7GMV8Bt2r7ZMF/qQXWB4nfCXiWc
         v/o09SznWDqr4C8Tu0bixBxO2mX7b4Uf8dzocn8qAWBYceFYpLAMCRPeqdZsoC/EtfpA
         UhTZmNhMxmKn3tQO0Z9g7KlsJoflC19jG9X8fCcsmYdLLq7FSpFeMlABWFlNSozTUnzH
         QZCw==
X-Gm-Message-State: AGi0Pua2Xg4ueGyxjlOUYIMO/sNfiaiG++gmsq516TSpReKffJnm0bTP
        hc3XE2akqL50uw00aopAmLkmjb6omjplt2JL8v61lw==
X-Google-Smtp-Source: APiQypK5tOtl3LZ3brTLoearB6mGZsDHZLQqxy8w8KCqYebAWwSHDLVSyGcKo81NZs2DksNSzf6cv1cpe3AAP3wrOoU=
X-Received: by 2002:a17:906:1dce:: with SMTP id v14mr13618659ejh.244.1588098291457;
 Tue, 28 Apr 2020 11:24:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAN-5tyE6JTeK7RFA7AkcO63p6iFE2v1+x2RFwRrTB1Jb1Yr76Q@mail.gmail.com>
In-Reply-To: <CAN-5tyE6JTeK7RFA7AkcO63p6iFE2v1+x2RFwRrTB1Jb1Yr76Q@mail.gmail.com>
From:   Olga Kornievskaia <aglo@umich.edu>
Date:   Tue, 28 Apr 2020 14:24:40 -0400
Message-ID: <CAN-5tyFkRN_LujHRPY6w-3rB66ePi-wfOOSMTgJn48eyyjdkCg@mail.gmail.com>
Subject: Re: handling ERR_SERVERFAULT on RESTOREFH
To:     linux-nfs <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Tue, Apr 28, 2020 at 2:14 PM Olga Kornievskaia <aglo@umich.edu> wrote:
>
> Hi folk,
>
> Looking for guidance on what folks think. A client is sending a LINK
> operation to the server. This compound after the LINK has RESTOREFH
> and GETATTR. Server returns SERVER_FAULT to on RESTOREFH. But LINK is
> done successfully. Client still fails the system call with EIO. We
> have a hardline and "ln" saying hardlink failed.

correction: have a hardlink.

> Should the client not fail the system call in this case? The fact that
> we couldn't get up-to-date attributes don't seem like the reason to
> fail the system call?
>
> Thank you.
