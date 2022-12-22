Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B298B653B24
	for <lists+linux-nfs@lfdr.de>; Thu, 22 Dec 2022 05:15:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbiLVEPA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 21 Dec 2022 23:15:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbiLVEO6 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 21 Dec 2022 23:14:58 -0500
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6CE01C91C;
        Wed, 21 Dec 2022 20:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1671682495; bh=sJZLYhzJgVAw2pHg01vEEbExYGChqpAWXl2KBNxoSwU=;
        h=X-UI-Sender-Class:Subject:From:To:Cc:Date:In-Reply-To:References;
        b=OPg3TUfUWI4FGVFYdQDTxm48BtLwiThA6/rCBojr+WgZst0rH8/AHV8CK+GBLlQcy
         wu7p7P4RBFyWUm1JDPEzVj0mtGUAKKzZlErFbvz80Ni43Ld4C3VZoO9/60CE4tlFIR
         gyY5aTyDLmgQLPC/oLAMw/i9rq2RU3dT3u2Obw6EjqybIrZPEKwjBxyovy5EIuz7d8
         MUcrJyfp/3hAohj0JLBU6DvGiLLGeWsAIrMCeC0zRIu0NDgnAIsZPyF1qtTZGwHoe/
         2iI+bWXYYf/c3+bJS1VAi+9gPZsBbBwS/CdXR55vriqR/C8y365iV1piE2FPk0Vdcn
         +BuJjwsUG2/Tg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from homer.fritz.box ([212.114.172.145]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MmDEg-1oQ6ik3ZTc-00iFmA; Thu, 22
 Dec 2022 05:14:54 +0100
Message-ID: <f533c2e38c0619ea0c3b4346d1c7c99c5ae2122b.camel@gmx.de>
Subject: Re: regression: nfs mount (even idle) eventually hangs server
From:   Mike Galbraith <efault@gmx.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     linux-nfs@vger.kernel.org
Date:   Thu, 22 Dec 2022 05:14:54 +0100
In-Reply-To: <241c118c2fb60df744bbe351387fc29a34ff6ab9.camel@gmx.de>
References: <65ed34338c69cb034295f2c9cbe0af684d65d30f.camel@gmx.de>
         <360f3dcfb6cfbefdbcc42fc84c660995142a8645.camel@gmx.de>
         <241c118c2fb60df744bbe351387fc29a34ff6ab9.camel@gmx.de>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:QkI4cL295yaUQQKm/lxy4FQuG7ZOJ5rd/y4cWN9bqmVv1TqIuLZ
 37ol3ZtFt0X1b7zTExiLv7xqWHUf9Jp+xBcqZjJlyzT1U/2RFCEUSAxVCMJdRP8GSttWOCe
 Om8UVmWwJOOlVeAfXR0LZYOgoLQvYhz0S/ETVzzyBvcYb2214G7G9f8lBX5NSMepXS+IlBk
 Ob/sHYkVzhod78yMOXPzw==
UI-OutboundReport: notjunk:1;M01:P0:RR2MlhI++m8=;zkkKIdcyfrkMrLfOb7uafYJq1Mh
 SvwfjD+etOmPFASjx7/4OuIbRRc2amO8mh9UYUU6ALuNC4nIBybualf4mlapLw6mErezHpJsw
 MD7EZ4/PfRActIl0r/wPQaljlMRPKri2tZepk3fR25S9eHyiC/OVuEoZeU7IKxXdG/ltCe88R
 1PFhSKlkyXqXIdAWOeFRg8unXbpd9UZilyYLeNlGBlEbpE/nq+87lCtALcUtqtUY/FfzRf93I
 uvWZvRGfLw0QeyCptSKbr8sQpkRLCByGgWSWN4vkPEs9GHwP605AzFkdyn8kwh25M83P9BQ0u
 1GPuAvUGrnR9OT0QebjoiuiVfrLVoL46L9F7+s9Ae9I2OsvIPsucYJ5/AaLZk42Gl5t7p7Plm
 sOqsRIQlceqFNmMhylXb+1dBUDS/M/cILYrdcCo8xD/PEppn3UVA19+5zEWjnULGWFueRmSIg
 8SQhJd+9x3dA5IgRRvxDAt1LpWjVAfwG907FMrDagOoHX0Q0YpfZKQOQxd+F7ZkuKWTY6Fus+
 lKsrSgaf0TvNYWb/Z+SAB8hc25+/Vy6YtDKOUnPpdUJC4JpFkfMxKcELGdfhoVtDhuLi2SOy8
 KqqiGFdHumVGHmO9IFhxSYxrNHmYj8qZCrYeUSGiuVk2WGh3dXqTFmU1eS14vXCx/rhsgSsu8
 E8y6CvA80PkG0F+w3Z/2Dvk5NB3fWN+nLEODaHVR8H3qn0wfqrOYwlvyw8fuyEGSNqwGkkDgg
 jlUucMrRCw3vtq6/S66xULuql0MIrJVzlL3BwzXLeEQ5yxIRwOTc7+GWMcc2jhm6ZNNPJUbJM
 Qm8t5xPtl3ilGozKFWxjPI/d+cZr9u434RWutbxOxeLLyzp4fjnWGEdWNBFB0QJV6D2W1TIKY
 EdK24A5ek/NBQ+SJJPbrVLo/X7Ta2WJABpyRSaG1S/eEvuvpeHQ/bwVJ73A9IfZln+JmPoFpc
 qxgaUjxCEz6JsGtq2k1y9bZWRic=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Thu, 2022-12-22 at 04:42 +0100, Mike Galbraith wrote:
> On Wed, 2022-12-21 at 10:56 +0100, Mike Galbraith wrote:
> > > 6.1 didn't reproduce either, so it would appear to be a merge window=
 bug.
>
> Ah, not true, turning evolution loose in nfs mounted home and letting
> it refresh mailboxes while desktop box was kept busy jammed up 6.1.0 in
> fairly short order. =C2=A0

Well crap.  That was _not_ virgin 6.1.0 after all, it was 6.1.0 with...

44df6f439a17 NFSD: add delegation reaper to react to low memory condition
3959066b697b NFSD: add support for sending CB_RECALL_ANY
a1049eb47f20 NFSD: refactoring courtesy_client_reaper to a generic low mem=
ory shrinker

...applied from poking about yesterday.  I had given up on those as
culprit, and intended to pop them off and rebuild, but they were in
fact in the booted kernel.  Oh well, booboo could have a bright side.

	-Mike
