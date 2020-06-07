Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55CF21F0D73
	for <lists+linux-nfs@lfdr.de>; Sun,  7 Jun 2020 19:44:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbgFGRom (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 7 Jun 2020 13:44:42 -0400
Received: from mout.kundenserver.de ([212.227.17.13]:42651 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726683AbgFGRol (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 7 Jun 2020 13:44:41 -0400
Received: from 'smile.earth' ([95.89.4.93]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MvJwN-1ir7bx2zmz-00rKDP; Sun, 07 Jun 2020 19:44:36 +0200
X-Virus-Scanned: amavisd at 'smile.earth'
From:   Hans-Peter Jansen <hpj@urpla.net>
To:     linux-nfs <linux-nfs@vger.kernel.org>,
        Anthony Joseph Messina <amessina@messinet.com>
Subject: Re: general protection fault,
 probably for non-canonical address in nfsd
Date:   Sun, 07 Jun 2020 19:44:35 +0200
Message-ID: <9727420.yF10LQ635x@xrated>
In-Reply-To: <11558085.O9o76ZdvQC@linux-ws1.messinet.com>
References: <15780697.tcFqIYE18H@xrated>
 <11558085.O9o76ZdvQC@linux-ws1.messinet.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K1:BgrKFYAsrmiPVqBD5o+jBRBgEO4MTR9c2pb4zXhbEUqgBsd+mL3
 mfLxN6WiTohLYHkSoVWYBOWjfrQhoUCdzvi0avM0RjXOBNazd0mayYY8sSLkl0EfaeocNNg
 8P8c7cef0//UCf4RE+obwHQ0pj8pdZNi3e2U3aOln4WVed5nPxGKgAXBafVK0qHjBeTj4Y7
 KKh1ETVbnCZftJGtFRZOA==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:k5ZMofGx2rs=:/OTvSnVOpHEwwx+qHDzQ2A
 Z7DkDwnCCA28qX1+U6c34p/NNSJcHaBbV59+T50+Ie1H6D9ffof4qMpVPgqdXdViqzYZC3ugp
 OdvspszyW9b+bWNP6+qg5XODCgneSkVS7qGLcAPLkzF48hRLdtTTaP6KDZoUUczAw35q3vtK2
 C1zAFLVlyN/ihMDFbP3Kp6ImaLTrLEHWDsiPtgGdEc5lmRERw5wTFqicJ4FUPAL4jNsb6CatY
 RdmsGLxdII1ByXIXJt0Ww2At0C76HBFqlyG02nKqmERVBDTmFJrw8RcKalvzZfxu6oYdUH7MW
 qz1IqqE6Lh042C+r6dTJ1UH2JH+/71K4ZYKidxqlN0NAHkWfKIfWibf4ZmCK5Y3bspa4N40ve
 A//7byC8edd6XNFMDKNW09GFSjUg/4wff6TQi5pTJ61+wZe9VtUB86P/5aPrSSoXC26TdPaqo
 7dfm3C1wkxhfKq+jZco/U1T1yl5boTEZWWTDp5mzq3V7CUhIzRyuoGyadOudF7ERHw4PwMH9Q
 SPY8Yeqhz4OpSmP1V/eNzhMhnXRny11qGEqpElEVFHM1ZMVhZDhRh+4vyYO/aMbVDuOOG8Ikl
 gQLN1+oEgz77fqwRqlCA/OPPfKBnC6KLVjgI5T+7s+3tEjUND6QWGJ2G21BR/8y0UsQU8G0F4
 m2Cu6BbXPO0LlXwM2oI1TH2wnuNLbqhOoSLUqwFm0RgPXwap6DQ1AfZbaRwWfBy+/V6KGvnyL
 Gf+7bgslIy62Net3b1PA7xP3pqPikyrMOI2RjKOTLWoEkuxFM/8GZN8OK5dVnZWBdV//H9GFv
 skQBvEOo+CmEwoSzIJ3cLFXjkehMJj3GHdY3gkzKGDg58zJecI=
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Am Sonntag, 7. Juni 2020, 18:01:55 CEST schrieb Anthony Joseph Messina:
> On Sunday, June 7, 2020 10:32:44 AM CDT Hans-Peter Jansen wrote:
> > Hi,
> > 
> > after upgrading the kernel from 5.6.11 to 5.6.14, we suffer from regular
> > crashes of nfsd here:
> > 
> > 2020-06-07T01:32:43.600306+02:00 server rpc.mountd[2664]: authenticated
> > mount request from 192.168.3.16:303 for /work (/work)
> > 2020-06-07T01:32:43.602594+02:00 server rpc.mountd[2664]: authenticated
> > mount request from 192.168.3.16:304 for /work/vmware (/work)
> > 2020-06-07T01:32:43.602971+02:00 server rpc.mountd[2664]: authenticated
> > mount request from 192.168.3.16:305 for /work/vSphere (/work)
> > 2020-06-07T01:32:43.606276+02:00 server kernel: [51901.089211] general
> > protection fault, probably for non-canonical address 0xb9159d506ba40000:
> > 0000 [#1] SMP PTI 2020-06-07T01:32:43.606284+02:00 server kernel:
> > [51901.089226] CPU: 1 PID: 3190 Comm: nfsd Tainted: G           O
> > 5.6.14-lp151.2-default #1 openSUSE Tumbleweed (unreleased)
> > 2020-06-07T01:32:43.606286+02:00 server kernel: [51901.089234] Hardware
> > name: System manufacturer System Product Name/P7F-E, BIOS 0906
> 
> I see similar issues in Fedora kernels 5.6.14 through 5.6.16
> https://bugzilla.redhat.com/show_bug.cgi?id=1839287
> 
> On the client I mount /home with sec=krb5p, and /mnt/koji with sec=krb5

Thanks for confirmation. 

Apart from the hassle with server reboots, this issue has some DOS potential, 
I'm afraid.

Cheers,
Pete


