Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C991F1E9C
	for <lists+linux-nfs@lfdr.de>; Mon,  8 Jun 2020 19:53:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729451AbgFHRxk (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 8 Jun 2020 13:53:40 -0400
Received: from mout.kundenserver.de ([212.227.17.10]:51131 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726097AbgFHRxj (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Mon, 8 Jun 2020 13:53:39 -0400
Received: from 'smile.earth' ([95.89.4.93]) by mrelayeu.kundenserver.de
 (mreue108 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N9Mh8-1iusXs1tbg-015Kkf; Mon, 08 Jun 2020 19:53:28 +0200
X-Virus-Scanned: amavisd at 'smile.earth'
From:   Hans-Peter Jansen <hpj@urpla.net>
To:     Anthony Joseph Messina <amessina@messinet.com>,
        Chuck Lever <chuck.lever@oracle.com>
Cc:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: general protection fault,
 probably for non-canonical address in nfsd
Date:   Mon, 08 Jun 2020 19:53:26 +0200
Message-ID: <13519623.o9HzBvYcLm@xrated>
In-Reply-To: <2B6CBC8C-A1D4-4C39-AF45-958847C99572@oracle.com>
References: <15780697.tcFqIYE18H@xrated> <9727420.yF10LQ635x@xrated>
 <2B6CBC8C-A1D4-4C39-AF45-958847C99572@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Provags-ID: V03:K1:MMaA86dsNPwMAvL6QXFzHtyHniiJ09LciPQhpKQ3Sgk7Nx6DZRO
 OcrI1xVb8hLPo1wx4Zr2fetYqmlRaGmzMuFWa3Qsd+rvLnJw7yhbCyrfcgsYJMmgJOTSwRj
 QZ4dLuTTnqUq/CljNPqKxvityvec1RN/YKA+bsS7thu5tVAQhRAvU5V2wG64IawbXQzeJTs
 Ss/U/QBq6mCEsXOwuHrSg==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:ALEAB6CXgMA=:KWsvEXJ2HUupv0lZbq+APl
 OkSQOdc0hwv6ArEHVaUIswNudUKDhNagSnsmrc9ivTD6YHbKoZCcl5sVw4nJBGnrfy8FCu+qM
 V2th9Nde1QTiEBb7V6OasTMEHoik+3czUyXGTRlC/O3qw/p68/JO8o5QN1Wm8bjr3DJOCFDbb
 oR71NziyxquaiR7I41YqF1KCrD/wgWdrxy3XLOUm/+sb3QAYQhxSTLSWfJKthmGG/OssKKI9P
 dW5eef62RlXmGxLBvXWuf9HHa1EQvtfpx4mDBfHagFQIrNYQWCXqQv8hngCoVN4WhZ6rC2Njd
 DY5DiMWePXz6Q2B5+3DjMtQ26j/+LWqYZFfpVfqlcqpUDa+N6rkg1GfcpAfeVz7JlEsx1yK4y
 Wba9KIsDgXkrAVImTcF9kZG1azJpefAakO3wdCVuHXadWWEkNQE+vh+3vunvw2VxmYgAWcibV
 EPGS9TmOPwa+xZKnjzr1rD6t+o4ANMkiQSkbtxT8uT1q/Jq+lXHC5RFq9DNcxasr35UyrzkSh
 7RXs2Zuz6g+jpFEz8lPCMkcVzIw6FdSLu13s5FrSX8x+yYdeeN7rU72dpTHiRjoLof5r68UOV
 Vym85m4utqknblYa0Y7bUuJv9q4bsNG+QI4ky/xLOgFY4tnA0YVVNOhX0iXkeQR3SWTgbALhR
 /v8aBV7JdU34YqYXPBZ1gwT99C2F78ZuStLGjqk3k7EkXbIYwm5I34ch/2zdTr5RrMUxoDazo
 g5oS4IuIGQcnPYU08GkkpTWbnhWAgj28uwrzEkifpU/JEUTINfREhRFkj0lnls/+1mKCmGG7q
 oIdVYbl86ogIj08DeswqzMgJ1oBKkv1FVCuQd9iB8SuAuAfSv8=
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

Am Montag, 8. Juni 2020, 17:28:53 CEST schrieb Chuck Lever:
> > On Jun 7, 2020, at 1:44 PM, Hans-Peter Jansen <hpj@urpla.net> wrote:
> > 
> > Am Sonntag, 7. Juni 2020, 18:01:55 CEST schrieb Anthony Joseph Messina:
> >> On Sunday, June 7, 2020 10:32:44 AM CDT Hans-Peter Jansen wrote:
> >>> Hi,
> >>> 
> >>> after upgrading the kernel from 5.6.11 to 5.6.14, we suffer from regular
> >>> crashes of nfsd here:
> >>> 
> >>> 2020-06-07T01:32:43.600306+02:00 server rpc.mountd[2664]: authenticated
> >>> mount request from 192.168.3.16:303 for /work (/work)
> >>> 2020-06-07T01:32:43.602594+02:00 server rpc.mountd[2664]: authenticated
> >>> mount request from 192.168.3.16:304 for /work/vmware (/work)
> >>> 2020-06-07T01:32:43.602971+02:00 server rpc.mountd[2664]: authenticated
> >>> mount request from 192.168.3.16:305 for /work/vSphere (/work)
> >>> 2020-06-07T01:32:43.606276+02:00 server kernel: [51901.089211] general
> >>> protection fault, probably for non-canonical address 0xb9159d506ba40000:
> >>> 0000 [#1] SMP PTI 2020-06-07T01:32:43.606284+02:00 server kernel:
> >>> [51901.089226] CPU: 1 PID: 3190 Comm: nfsd Tainted: G           O
> >>> 5.6.14-lp151.2-default #1 openSUSE Tumbleweed (unreleased)
> >>> 2020-06-07T01:32:43.606286+02:00 server kernel: [51901.089234] Hardware
> >>> name: System manufacturer System Product Name/P7F-E, BIOS 0906
> >> 
> >> I see similar issues in Fedora kernels 5.6.14 through 5.6.16
> >> https://bugzilla.redhat.com/show_bug.cgi?id=1839287
> >> 
> >> On the client I mount /home with sec=krb5p, and /mnt/koji with sec=krb5
> > 
> > Thanks for confirmation.
> > 
> > Apart from the hassle with server reboots, this issue has some DOS
> > potential, I'm afraid.
> 
> If you have a reproducer (even a partial one) then bisecting between a
> known good kernel and v5.6.14 (or 16) would be helpful.

I would love to bisect, but this is my primary production machine, that needs 
to be up as much as possible. Apart from that, I'm about to leave the site for 
a week and been severely time constrained for the next couple of weeks..

Sorry. 

Anthony?
--
Pete


