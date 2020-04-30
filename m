Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C81A31BF01D
	for <lists+linux-nfs@lfdr.de>; Thu, 30 Apr 2020 08:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726391AbgD3GQW (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 30 Apr 2020 02:16:22 -0400
Received: from etc.inittab.org ([51.254.149.154]:56390 "EHLO etc.inittab.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726358AbgD3GQW (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Thu, 30 Apr 2020 02:16:22 -0400
X-Greylist: delayed 494 seconds by postgrey-1.27 at vger.kernel.org; Thu, 30 Apr 2020 02:16:22 EDT
Received: from var.inittab.org (89.141.236.227.dyn.user.ono.com [89.141.236.227])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: smtp_auth_agi@correo-e.org)
        by etc.inittab.org (Postfix) with ESMTPSA id 8391EA0072
        for <linux-nfs@vger.kernel.org>; Thu, 30 Apr 2020 08:08:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=inittab.org;
        s=default; t=1588226886;
        bh=lIeYDZx5LRUpTU9kcHHAc9agDV0BH0P1yKjNF/7yVqM=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=j35MPSCuYGgzdDfpreAyQ/udAA3iqPas60DGT+5fMtZvoK8c/qdIAVqsYqWTf8nGp
         AzrhMbgl5XAfcedqnUgivm0sadiWgXlkhPfOF2bP/Onk35kWaL45i4NjTn0Y69wy2K
         EEDHCuH4Vt0HY8vLBtBFAXVeFr+0GxQhIq/3QM40=
Received: by var.inittab.org (Postfix, from userid 1000)
        id 1FADE4267A; Thu, 30 Apr 2020 08:08:06 +0200 (CEST)
Date:   Thu, 30 Apr 2020 08:08:06 +0200
From:   Alberto Gonzalez Iniesta <agi@inittab.org>
To:     linux-nfs@vger.kernel.org
Subject: Re: Random IO errors on nfs clients running linux > 4.20
Message-ID: <20200430060806.GJ2531021@var.inittab.org>
References: <20200429171527.GG2531021@var.inittab.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200429171527.GG2531021@var.inittab.org>
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

On Wed, Apr 29, 2020 at 07:15:27PM +0200, Alberto Gonzalez Iniesta wrote:
> Hello NFS maintainers,
>
> I know we aren't providing much info but we are really looking forward
> to doing all the testing required (we already spent lots of time in it).

Hi,

Sorry, I was providing way too little info...
We're using NFSv4 with kerberos, mounts are done with:
mount -t nfs4 -o sec=krb5p,exec,noauto pluto.XXXX:/publico /media/pluto

Regards,

Alberto

-- 
Alberto Gonzalez Iniesta    | Formación, consultoría y soporte técnico
mailto/sip: agi@inittab.org | en GNU/Linux y software libre
Encrypted mail preferred    | http://inittab.com

Key fingerprint = 5347 CBD8 3E30 A9EB 4D7D  4BF2 009B 3375 6B9A AA55
