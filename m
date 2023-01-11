Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F27665CE8
	for <lists+linux-nfs@lfdr.de>; Wed, 11 Jan 2023 14:49:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjAKNtC (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 11 Jan 2023 08:49:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239278AbjAKNst (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 11 Jan 2023 08:48:49 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07FF05F8C
        for <linux-nfs@vger.kernel.org>; Wed, 11 Jan 2023 05:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1673444917; bh=Q47MEk19eHaWJR8DEJ16u7goQAMWxkFvd5sWyZMNC4M=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=NDvk9JhvVpjG6zC4LVof6M/bqcXrmJ97YqDhUDh0sOP3OTvCkbeeJxkk3H06QMMjQ
         PgrR1uRBVXlaceLD2ki4W3L3KtXSd/iIO+s++vRWxVvbbfsyX4+r6OtKY8BDYXaypf
         cDfNAOmSubbL7pNm0sDer6NS/XW4CcQI3lHjNhr7ZlH6VR4xRWyFoNPo3E9SpvwX7N
         JMW7cuM+fBKahgxGegpyF/FMJYktK+Rq4nCqykSXGAGg6Qy4pw4NPL79Oh7memyqds
         2hhADCpF+qBDeq2/0Y/h8jH/5mOZBRk3xClaMi54yc45iPkZPnqH8PevvtKt01znZi
         D39x8vDDGt0Kg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([185.146.48.212]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MacSe-1odVZ12C5q-00cA8M; Wed, 11
 Jan 2023 14:48:37 +0100
Message-ID: <c2d13c973a2ef364314441503281ba5887a143aa.camel@gmx.de>
Subject: Re: [PATCH 1/1] NFSD: fix WARN_ON_ONCE in __queue_delayed_work
From:   Mike Galbraith <efault@gmx.de>
To:     Jeff Layton <jlayton@kernel.org>, dai.ngo@oracle.com,
        Chuck Lever III <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Date:   Wed, 11 Jan 2023 14:48:36 +0100
In-Reply-To: <5f43a396afec99352bc1dd62a9119281e845c652.camel@kernel.org>
References: <1673333310-24837-1-git-send-email-dai.ngo@oracle.com>
         <57dc06d57b4b643b4bf04daf28acca202c9f7a85.camel@kernel.org>
         <71672c07-5e53-31e6-14b1-e067fd56df57@oracle.com>
         <8C3345FB-6EDF-411A-B942-5AFA03A89BA2@oracle.com>
         <5e34288720627d2a09ae53986780b2d293a54eea.camel@kernel.org>
         <42876697-ba42-c38f-219d-f760b94e5fed@oracle.com>
         <f0f56b451287d17426defe77aee1b1240d2a1b31.camel@kernel.org>
         <8e0cb925-9f73-720d-b402-a7204659ff7f@oracle.com>
         <37c80eaf2f6d8a5d318e2b10e737a1c351b27427.camel@gmx.de>
         <ce3724b88bb2987ac773057f523aa0ed2abacaed.camel@kernel.org>
         <2067b4b4ce029ab5be982820b81241cd457ff475.camel@kernel.org>
         <ec6593bce96f8a6a7928394f19419fb8a4725413.camel@gmx.de>
         <fe19401301eac98927d6b4fc9fbf9c8430890751.camel@gmx.de>
         <5f43a396afec99352bc1dd62a9119281e845c652.camel@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XU+9fhf5AFi+PUt4mVx+3+ROqWMksaQDzI25TLV0TSyLsl2rdHT
 s3kVloAK8F3DnWhyaIjkKfhlSkKMxzOYAxBUkdYuj+YXqGTJv3RweOJkwv47fGnV8/Fpzsh
 FrQQ3BlMAE7hfucrblaHGx2BEHcZAtfdLSMSMVOFuLCKAJrXA4LOwlpBg5Sa+TMHxA2Kh+H
 rmswDZhlyv5Y3HdNebZ7g==
UI-OutboundReport: notjunk:1;M01:P0:r9duZ0gOB2M=;TRiEFyiOJkXabNhdDhQdFA1rMEo
 QprfeifmXIKlqFe8l2UUKjdE5u+1jnwIykHEr4gbNAZ/dGChfnrg+If1xbD4SIDTiiu1czI6C
 4vlk45NQfVe8vwKttaa8cEg+ObSWCqntjB87LPudH3Ch+rEjJmKmw3ypdaOksG8bzgEz3R+OR
 Q+X/f2DLA80zLmopBp9AWJx1QGu6vLqWQbNhJjZECCvlLZ46x6LQ3gRlpclZha0qO9bSIvhPx
 tNgcQEf3d1EKRxDjH75HvtsWjFvLZhjcYaM9xQ4h4FdMKMCNP8okSC+XZ7BrtHxbe0fnF8Gpp
 LQD8X3WbJk3qs1CjNH4mmZAV+5xWpVl9/PgyahStMiMvZEjd5oCuuqtReasKIUdX+WeROHq0F
 t38Co2qdKMoNbXq3zQHn5h8Dp0g8tu9pxi+8/MCyLPh0Ull4txnF46jmw7F3gjpcNIgFlsLlT
 TDSPwZA5gQDU8Q1rsAQwgOJN+LjUuGFYNqbyPyXGaxP9Rngbc0xvnfOpQsB56SpetbC4TYE5D
 6WlSpK1jfr6nhiycKCQqoOjjh6F7n4hIZGYo0BSBYl8QZiVO3xXTv9MFLK9l6pj4upVpomBQR
 7wm+PVV9PXv9LkVZZZoj+9Utpw8lEHQMIAUUWOp7KoR1AAMytoc8gDSR5HGY+ZdOSyff0cMvi
 HemMgUicTGdFbj4+M8XM+ehbiLey21CWMYTPw6bEiEi2rx1m3B4s0MO7XBJn0JQssHDaIUnmd
 ymqSTSDiEaJ4qOD0vmzRLNywf2rc3R7xDyFUvfnOfQo352ljeM/Qfo27P+4dpLmhN9NH9aLy9
 PNa0qWBgqKJo3dSO4C9qRYfWmZNpz2ZcpKeB8fBdIZlCDdXCk15LHl5eD+eQGWZpdnjb1ZPtE
 0bMc8lUxQztSeybmQu5FLDPgZ8znBxN+gx5EGZYMJ3dvc6F+95X2tkkRNANT6EepFOZWOqa+o
 8AIHImjdSlTOU2aU7BNUSEssro4=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, 2023-01-11 at 07:33 -0500, Jeff Layton wrote:
>
> One thing that might interesting to rule out a UAF would be to
> explicitly poison this struct in nfsd_exit_net. Basically do something
> like this at the end of exit_net:
>
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0memset(net, 0x7c, sizeof=
(*net));
>
> That might help trigger an oops sooner after the problem occurs.

Blasting net rendered the VM non-booting.  Blasting nn OTOH seems to
have changed nothing at all.

> If you're feeling ambitious, another thing you could do is track down
> some of the running nfsd's in the vmcore, find their rqstp values and
> see whether the sockets are pointed at the same nfsd_net as the one you
> found above (see nfsd() function to see how to get from one to the
> other).
>
> If they're pointed at a different nfsd_net that that would suggest that
> we are looking at a UAF. If it's the same nfsd_net, then I'd lean more
> toward some sort of memory scribble.

Way better: scrawny NFS chimp hands dump to big/strong NFS gorilla :)

	-Mike
