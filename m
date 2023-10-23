Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A40A47D3CC9
	for <lists+linux-nfs@lfdr.de>; Mon, 23 Oct 2023 18:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjJWQoS (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 23 Oct 2023 12:44:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229544AbjJWQoR (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 23 Oct 2023 12:44:17 -0400
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8E938E;
        Mon, 23 Oct 2023 09:44:15 -0700 (PDT)
Received: by mail-qv1-xf32.google.com with SMTP id 6a1803df08f44-66d09b6d007so25630026d6.1;
        Mon, 23 Oct 2023 09:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698079455; x=1698684255; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BGTQYMFPpXuQ/hm3cgO//PE+4QyM6sGQHf352NdYoOA=;
        b=a6rO0X2zskHUUdzn83Wj8C7b+lGquw37jZToZi6PIi78aeew49dJAaOpIv76mwsdNz
         oCLF0QS+hnpvsXnDMTL3/Y2gFfDh/fVSkRaqZkcl186F6slau5IfoYY+Z1mtkpT5m/SH
         eA2ov4mGIrl/R+jHB9F9zFU+tcwwkuWZTbyXewVoBXJ0WGoJr1vRSMOEWJIfr8zylRvc
         rEusLvrQwHJ36vOTY3oDIN5e0lvuEbrPpxkgXBhGigpg5CC77jWiRHs8EsZePxp/QcaR
         px4GbxedWeRrdUVk5UFRrhmLkwJJ4GJl8tV1hyJMCMbZVIBn5WvRkusZHD/Nk5vWAQ97
         LOvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698079455; x=1698684255;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BGTQYMFPpXuQ/hm3cgO//PE+4QyM6sGQHf352NdYoOA=;
        b=vvXZe21BrQgR9aEu2k6VgATpYx519pJWqXZXjCxn4RmUfZHcPl6SbFgZLVn00rSxgO
         btlRJJ27yAttYAX1dhxToTFdwEeKH+CUZ+iyjthy3zxrSigGQW54KnFMlde031Nh3KqA
         4VaH87jtmXEtdpYb2TWM0pa9TdOU2GhvHhIRwkTVMcTC3HPpW2zMpyt1qYhlZz00PeUy
         CgDdAiphWsfjwqZTMKvfaRBH0HrxtVA0A/OYo4jq6P6aCpd+z7sFe4QXfSo4fsuvpyo5
         3ZWP+PZxTOqURpLLUAu9XduQHtNlIHhfLAb8TqSAezLPDOZQrQV9EiuNZHQQeBuiX1Ar
         6OEw==
X-Gm-Message-State: AOJu0Yz80GpiJvWEXIoOxmutCSRQYmFILkt79ezz3yIIf5DnJMS7Rnh1
        26JMYYegBq8JWTpbm0GSpOQPo7dus/tcD2E9Jic=
X-Google-Smtp-Source: AGHT+IHbDDbp9ITF5wztijgJ/vhFLt5sif4XgHrx2vxvQTHVLkHC7VejE6I+inFBaksA5v/xT1GyMROqI0rowldHIRo=
X-Received: by 2002:ad4:5f07:0:b0:658:997f:79b7 with SMTP id
 fo7-20020ad45f07000000b00658997f79b7mr12538546qvb.3.1698079454938; Mon, 23
 Oct 2023 09:44:14 -0700 (PDT)
MIME-Version: 1.0
References: <20231018100000.2453965-1-amir73il@gmail.com> <20231018100000.2453965-6-amir73il@gmail.com>
 <CAOQ4uxhiRU2nNnYtuXUaURMCuYjssC9Rn=ORWW=MmVyMD1H6Rg@mail.gmail.com> <20231023163308.7szzloiuzzc7lnia@quack3>
In-Reply-To: <20231023163308.7szzloiuzzc7lnia@quack3>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 23 Oct 2023 19:44:03 +0300
Message-ID: <CAOQ4uxjnK5XNjRsza6mrUzXcqSgCZ9G6MuMTt1X_B6QTwCoWDw@mail.gmail.com>
Subject: Re: [PATCH 5/5] exportfs: support encoding non-decodeable file
 handles by default
To:     Jan Kara <jack@suse.cz>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Mon, Oct 23, 2023 at 7:33=E2=80=AFPM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 23-10-23 16:55:40, Amir Goldstein wrote:
> > On Wed, Oct 18, 2023 at 1:00=E2=80=AFPM Amir Goldstein <amir73il@gmail.=
com> wrote:
> > >
> > > AT_HANDLE_FID was added as an API for name_to_handle_at() that reques=
t
> > > the encoding of a file id, which is not intended to be decoded.
> > >
> > > This file id is used by fanotify to describe objects in events.
> > >
> > > So far, overlayfs is the only filesystem that supports encoding
> > > non-decodeable file ids, by providing export_operations with an
> > > ->encode_fh() method and without a ->decode_fh() method.
> > >
> > > Add support for encoding non-decodeable file ids to all the filesyste=
ms
> > > that do not provide export_operations, by encoding a file id of type
> > > FILEID_INO64_GEN from { i_ino, i_generation }.
> > >
> > > A filesystem may that does not support NFS export, can opt-out of
> > > encoding non-decodeable file ids for fanotify by defining an empty
> > > export_operations struct (i.e. with a NULL ->encode_fh() method).
> > >
> > > This allows the use of fanotify events with file ids on filesystems
> > > like 9p which do not support NFS export to bring fanotify in feature
> > > parity with inotify on those filesystems.
> > >
> > > Note that fanotify also requires that the filesystems report a non-nu=
ll
> > > fsid.  Currently, many simple filesystems that have support for inoti=
fy
> > > (e.g. debugfs, tracefs, sysfs) report a null fsid, so can still not b=
e
> > > used with fanotify in file id reporting mode.
> > >
> > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > > ---
> >
> > Hi Jan,
> >
> > Did you get a chance to look at this patch?
> > I saw your review comments on the rest of the series, so was waiting
> > for feedback on this last one before posting v2.
>
> Ah, sorry. I don't have any further comments regarding this patch besides
> what Chuck already wrote.

No worries.
I will post v2 with minor fixes and add your RVB to all patches.

Thanks,
Amir.
