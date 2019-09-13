Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3343B297D
	for <lists+linux-nfs@lfdr.de>; Sat, 14 Sep 2019 05:36:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390908AbfINDgQ (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 13 Sep 2019 23:36:16 -0400
Received: from elasmtp-masked.atl.sa.earthlink.net ([209.86.89.68]:56690 "EHLO
        elasmtp-masked.atl.sa.earthlink.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2390905AbfINDgQ (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 13 Sep 2019 23:36:16 -0400
X-Greylist: delayed 40791 seconds by postgrey-1.27 at vger.kernel.org; Fri, 13 Sep 2019 23:36:16 EDT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mindspring.com;
        s=dk12062016; t=1568432176; bh=yXTPe/4asCX0ogVmzm2LRYU/4ozOO5vsPXEg
        A6rmfEI=; h=Received:From:To:References:In-Reply-To:Subject:Date:
         Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:
         X-Mailer:Thread-Index:Content-Language:X-ELNK-Trace:
         X-Originating-IP; b=KhkDvgdE5njG+Bt3dp0G1p2j2WGamCEV5Et8Q3hnMUl8k6
        iAWrls4SRn/T8qBPT+IeziBv2Wupvu926obv+xad/1BQpuAba8aYkuDtGwFE27BYvbI
        ELm8xocjuTHC84CGXLcs/oIhYOjJeOdMzzPL/6OyE2fVxEohNaVK1Rv11UrdTVb5f2B
        /oPJ2jRMxAB2U05yQckFIGSIkF360x18EQcTMS1sprfy6J3RHnAJviYSjEFGwILYCFI
        AADUYS4nUsZuRrAH1mglgJ8Tqe3GdOpYB/VXbmBMzUjGwiHb7+95c0htv1R4yzHXSM1
        Vkf6xTi8L1nTB4I3sbIG4RVUjqWQ==
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=dk12062016; d=mindspring.com;
  b=W8gln25pTE7EfOw31mxfeICyibmTLd429MskPD80AiiIVxyCmO4x59Os9HYTgEm3D7DEerVhQ1xILIoXPb5kCrIbmab/I5FPz2aSFIvWsdSUN4bc0iQv8eHKgQYpCjibYqZOQSVLkBD8WmyjA9DSr+OSxe4rbl4JBLE5R/hdAUkdamS+y9QCJ5Rm/4cS7t3NAlwguvNI7Iht0zdRjo2p+iffTrOwBOGEKAWRZq71G11kb+lC7GdDEC3hy7tNG/SZRQIo4rZySZz9wbvN+ZWKXY9T7CtjU6DDIUsovCeG7EcVHIe8mSVl5hMT6RZpPMnkyXxtvvH8ShDLAfGG19kvWg==;
  h=Received:From:To:References:In-Reply-To:Subject:Date:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:Thread-Index:Content-Language:X-ELNK-Trace:X-Originating-IP;
Received: from [76.105.143.216] (helo=FRANKSTHINKPAD)
        by elasmtp-masked.atl.sa.earthlink.net with esmtpa (Exim 4)
        (envelope-from <ffilzlnx@mindspring.com>)
        id 1i8oFD-0009YP-Kx; Fri, 13 Sep 2019 12:16:23 -0400
From:   "Frank Filz" <ffilzlnx@mindspring.com>
To:     <dang@redhat.com>, "'Olga Kornievskaia'" <aglo@umich.edu>,
        "'linux-nfs'" <linux-nfs@vger.kernel.org>
References: <CAN-5tyG97C6GTXOz5G6z8SL+jNKYa0siWnSfjijRNVucFs3KwA@mail.gmail.com> <080bf93a-0e66-bb56-a54f-5496c688bb70@redhat.com>
In-Reply-To: <080bf93a-0e66-bb56-a54f-5496c688bb70@redhat.com>
Subject: RE: support for UDP
Date:   Fri, 13 Sep 2019 09:16:23 -0700
Message-ID: <09ff01d56a4e$96857660$c3906320$@mindspring.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQH5HHcSgQ9YLcaKJGu1LCOipit+sQH3xOe4ptKlgVA=
Content-Language: en-us
X-ELNK-Trace: 136157f01908a8929c7f779228e2f6aeda0071232e20db4dc5db1cb85d1b96aeee988463eabe8cbe350badd9bab72f9c350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 76.105.143.216
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

> On 9/13/19 11:14 AM, Olga Kornievskaia wrote:
> > Hi folks,
> >
> > I'd like to gauge what people think. Do you think we'd ever do a =
bold
> > thing like drop the UDP support in the upstream kernel (obviously =
with
> > a plan to fade it out with a config option that we did with the des
> > support)...
> >
>=20
> Yes, please.

Yea, it would certainly be nice to not have to worry about UDP =
connections. They don't work for NFS in high speed high bandwidth =
workloads due to the issues with fragment reassembly. Their use for NFS =
v3 sideband protocols doesn't really buy much.

Of course we'll still have to support UDP for 10 more years...

Frank

