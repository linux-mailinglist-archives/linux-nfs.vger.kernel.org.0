Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BAAD298E7F
	for <lists+linux-nfs@lfdr.de>; Mon, 26 Oct 2020 14:51:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1780688AbgJZNvk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 26 Oct 2020 09:51:40 -0400
Received: from etc.inittab.org ([51.254.149.154]:54160 "EHLO etc.inittab.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1421385AbgJZNvj (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 26 Oct 2020 09:51:39 -0400
X-Greylist: delayed 558 seconds by postgrey-1.27 at vger.kernel.org; Mon, 26 Oct 2020 09:51:38 EDT
Received: from var.inittab.org (249.171.116.91.static.reverse-mundo-r.com [91.116.171.249])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: smtp_auth_agi@correo-e.org)
        by etc.inittab.org (Postfix) with ESMTPSA id 74FBAA10BA;
        Mon, 26 Oct 2020 14:42:17 +0100 (CET)
Received: by var.inittab.org (Postfix, from userid 1000)
        id 9B6A3404E9; Mon, 26 Oct 2020 14:42:16 +0100 (CET)
Date:   Mon, 26 Oct 2020 14:42:16 +0100
From:   Alberto Gonzalez Iniesta <alberto.gonzalez@udima.es>
To:     "J. Bruce Fields" <bfields@fieldses.org>
Cc:     linux-nfs@vger.kernel.org,
        Miguel Rodriguez <miguel.rodriguez@udima.es>,
        Isaac Marco Blancas <isaac.marco@udima.es>
Subject: Re: Random IO errors on nfs clients running linux > 4.20
Message-ID: <20201026134216.GK74269@var.inittab.org>
References: <20200429171527.GG2531021@var.inittab.org>
 <20200430173200.GE29491@fieldses.org>
 <20200909092900.GO189595@var.inittab.org>
 <20200909134727.GA3894@fieldses.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200909134727.GA3894@fieldses.org>
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Sep 09, 2020 at 09:47:27AM -0400, J. Bruce Fields wrote:
> On Wed, Sep 09, 2020 at 11:29:00AM +0200, Alberto Gonzalez Iniesta wrote:
> > On Thu, Apr 30, 2020 at 01:32:00PM -0400, J. Bruce Fields wrote:
> > > On Wed, Apr 29, 2020 at 07:15:27PM +0200, Alberto Gonzalez Iniesta wrote:
> > > > We can run the previous "ls -lR" 20 times and get no error, or get
> > > > this "ls: leyendo el directorio 'Becas y ayudas/': Error de entrada/salida"
> > > > (ls: reading directorio 'Becas y ayudas/': Input/Output Error") every
> > > > now and then.
> > > > 
> > > > The error happens (obviously?) with ls, rsync and the users's GUI tools.
> > > > 
> > > > There's nothing in dmesg (or elsewhere).
> > > > These are the kernels with tried:
> > > > 4.18.0-25   -> Can't reproduce
> > > > 4.19.0      -> Can't reproduce
> > > > 4.20.17     -> Happening (hard to reproduce)
> > > > 5.0.0-15    -> Happening (hard to reproduce)
> > > > 5.3.0-45    -> Happening (more frequently)
> > > > 5.6.0-rc7   -> Reproduced a couple of times after boot, then nothing
> > > > 
> > > > We did long (as in daylong) testing trying to reproduce this with all
> > > > those kernel versions, so we are pretty sure 4.18 and 4.19 don't
> > > > experience this and our Ubuntu 16.04 clients don't have any issue.
> > > > 
> > > > I know we aren't providing much info but we are really looking forward
> > > > to doing all the testing required (we already spent lots of time in it).
> > > > 
> > > > Thanks for your work.
> 
> So all I notice from this one is the readdir EIO came from call_decode.
> I suspect that means it failed in the xdr decoding.  Looks like xdr
> decoding of the actual directory data (which is the complicated part) is
> done later, so this means it failed decoding the header or verifier,
> which is a little odd:
> 
> > Sep  8 16:03:23 portatil264 kernel: [15033.016276] RPC:  3284 call_decode result -5
> > Sep  8 16:03:23 portatil264 kernel: [15033.016281] nfs41_sequence_process: Error 1 free the slot 
> > Sep  8 16:03:23 portatil264 kernel: [15033.016286] RPC:       wake_up_first(00000000d3f50f4d "ForeChannel Slot table")
> > Sep  8 16:03:23 portatil264 kernel: [15033.016288] nfs4_free_slot: slotid 0 highest_used_slotid 4294967295
> > Sep  8 16:03:23 portatil264 kernel: [15033.016290] RPC:  3284 return 0, status -5
> > Sep  8 16:03:23 portatil264 kernel: [15033.016291] RPC:  3284 release task
> > Sep  8 16:03:23 portatil264 kernel: [15033.016295] RPC:       freeing buffer of size 4144 at 00000000a3649daf
> > Sep  8 16:03:23 portatil264 kernel: [15033.016298] RPC:  3284 release request 0000000079df89b2
> > Sep  8 16:03:23 portatil264 kernel: [15033.016300] RPC:       wake_up_first(00000000c5ee49ee "xprt_backlog")
> > Sep  8 16:03:23 portatil264 kernel: [15033.016302] RPC:       rpc_release_client(00000000b930c343)
> > Sep  8 16:03:23 portatil264 kernel: [15033.016304] RPC:  3284 freeing task
> > Sep  8 16:03:23 portatil264 kernel: [15033.016309] _nfs4_proc_readdir: returns -5
> > Sep  8 16:03:23 portatil264 kernel: [15033.016318] NFS: readdir(departamentos/innovacion) returns -5

Hi, Bruce et al.

Is there anything we can do to help debugging/fixing this? It's still
biting our users with a +4.20.x kernel.

Thanks,

Alberto

-- 
Alberto González Iniesta             | Universidad a Distancia
alberto.gonzalez@udima.es            | de Madrid
