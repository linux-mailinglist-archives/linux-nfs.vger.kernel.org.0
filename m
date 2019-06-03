Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0E7393373B
	for <lists+linux-nfs@lfdr.de>; Mon,  3 Jun 2019 19:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbfFCRtn (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Mon, 3 Jun 2019 13:49:43 -0400
Received: from fmap.me ([51.75.121.85]:35888 "EHLO fmap.me"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727230AbfFCRtm (ORCPT <rfc822;linux-nfs@vger.kernel.org>);
        Mon, 3 Jun 2019 13:49:42 -0400
X-Greylist: delayed 608 seconds by postgrey-1.27 at vger.kernel.org; Mon, 03 Jun 2019 13:49:40 EDT
To:     steved@redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fmap.me; s=mail;
        t=1559583571; h=from:from:sender:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:content-transfer-encoding:in-reply-to:
         references:openpgp:autocrypt; bh=rIUFEPQmfSyFGvwJ1RszmddCo0nE7QS/fdpi57Qv52A=;
        b=DA/p7e96OfVB3cKw6QCAHItLYs2o5e9d754ZarUP2+BZQzgqyyyxco46qen9kUnbdqh47c
        HL5Uom9/AxVPCQb1whWZlsI7raT3GTNMXh/Dwj1zmNeKtXH+IWKhYNH0YJ/ZfBDsubnxrK
        EFKdJWPz/723ZJvlHpM3pdOqs8ZoHG4=
Cc:     linux-nfs@vger.kernel.org
From:   Nikolay Amiantov <ab@fmap.me>
Subject: nfs-utils v2.3.4: tests fail to build
Message-ID: <3f65e5e6-4343-ae8c-7cbd-aaf60787501d@fmap.me>
Date:   Mon, 3 Jun 2019 20:39:30 +0300
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------7426ECB91D08A2392B66C2C0"
Content-Language: en-US
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is a multi-part message in MIME format.
--------------7426ECB91D08A2392B66C2C0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

During the build of recent nfs-utils `make check` fails with link
errors. We build it in an isolated sandbox with Nix on NixOS but
I tried to build it outside of a sandbox too.

Attached is the build log.

I've been advised to drop an email to you at [1] which was
my initial guess on where to send this bug. I mentioned there it's
a regression but upon further inspection this problem was there
at least on 2.3.3, just masked by something else.

1: https://bugzilla.kernel.org/show_bug.cgi?id=203793

--
Nikolay.


--------------7426ECB91D08A2392B66C2C0
Content-Type: text/x-log;
 name="check.log"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="check.log"

check flags: SHELL=3D/nix/store/x0mlaj4z4ciycaycfwc36l1932mwywfj-bash-4.4=
-p23/bin/bash sbindir=3D\$\(out\)/bin generator_dir=3D\$\(out\)/etc/syste=
md/system-generators VERBOSE=3Dy check
Making check in support
make[1]: Entering directory '/build/nfs-utils-2.3.4/support'
Making check in export
make[2]: Entering directory '/build/nfs-utils-2.3.4/support/export'
make  check-am
make[3]: Entering directory '/build/nfs-utils-2.3.4/support/export'
make[3]: Nothing to be done for 'check-am'.
make[3]: Leaving directory '/build/nfs-utils-2.3.4/support/export'
make[2]: Leaving directory '/build/nfs-utils-2.3.4/support/export'
Making check in include
make[2]: Entering directory '/build/nfs-utils-2.3.4/support/include'
Making check in nfs
make[3]: Entering directory '/build/nfs-utils-2.3.4/support/include/nfs'
make[3]: Nothing to be done for 'check'.
make[3]: Leaving directory '/build/nfs-utils-2.3.4/support/include/nfs'
Making check in rpcsvc
make[3]: Entering directory '/build/nfs-utils-2.3.4/support/include/rpcsv=
c'
make[3]: Nothing to be done for 'check'.
make[3]: Leaving directory '/build/nfs-utils-2.3.4/support/include/rpcsvc=
'
Making check in sys
make[3]: Entering directory '/build/nfs-utils-2.3.4/support/include/sys'
Making check in fs
make[4]: Entering directory '/build/nfs-utils-2.3.4/support/include/sys/f=
s'
make[4]: Nothing to be done for 'check'.
make[4]: Leaving directory '/build/nfs-utils-2.3.4/support/include/sys/fs=
'
make[4]: Entering directory '/build/nfs-utils-2.3.4/support/include/sys'
make[4]: Nothing to be done for 'check-am'.
make[4]: Leaving directory '/build/nfs-utils-2.3.4/support/include/sys'
make[3]: Leaving directory '/build/nfs-utils-2.3.4/support/include/sys'
make[3]: Entering directory '/build/nfs-utils-2.3.4/support/include'
make[3]: Leaving directory '/build/nfs-utils-2.3.4/support/include'
make[2]: Leaving directory '/build/nfs-utils-2.3.4/support/include'
Making check in misc
make[2]: Entering directory '/build/nfs-utils-2.3.4/support/misc'
make[2]: Nothing to be done for 'check'.
make[2]: Leaving directory '/build/nfs-utils-2.3.4/support/misc'
Making check in nfs
make[2]: Entering directory '/build/nfs-utils-2.3.4/support/nfs'
make[2]: Nothing to be done for 'check'.
make[2]: Leaving directory '/build/nfs-utils-2.3.4/support/nfs'
Making check in nsm
make[2]: Entering directory '/build/nfs-utils-2.3.4/support/nsm'
make  check-am
make[3]: Entering directory '/build/nfs-utils-2.3.4/support/nsm'
make[3]: Nothing to be done for 'check-am'.
make[3]: Leaving directory '/build/nfs-utils-2.3.4/support/nsm'
make[2]: Leaving directory '/build/nfs-utils-2.3.4/support/nsm'
Making check in nfsidmap
make[2]: Entering directory '/build/nfs-utils-2.3.4/support/nfsidmap'
make[2]: Nothing to be done for 'check'.
make[2]: Leaving directory '/build/nfs-utils-2.3.4/support/nfsidmap'
make[2]: Entering directory '/build/nfs-utils-2.3.4/support'
make[2]: Nothing to be done for 'check-am'.
make[2]: Leaving directory '/build/nfs-utils-2.3.4/support'
make[1]: Leaving directory '/build/nfs-utils-2.3.4/support'
Making check in tools
make[1]: Entering directory '/build/nfs-utils-2.3.4/tools'
Making check in locktest
make[2]: Entering directory '/build/nfs-utils-2.3.4/tools/locktest'
make[2]: Nothing to be done for 'check'.
make[2]: Leaving directory '/build/nfs-utils-2.3.4/tools/locktest'
Making check in rpcdebug
make[2]: Entering directory '/build/nfs-utils-2.3.4/tools/rpcdebug'
make[2]: Nothing to be done for 'check'.
make[2]: Leaving directory '/build/nfs-utils-2.3.4/tools/rpcdebug'
Making check in nlmtest
make[2]: Entering directory '/build/nfs-utils-2.3.4/tools/nlmtest'
make[2]: Nothing to be done for 'check'.
make[2]: Leaving directory '/build/nfs-utils-2.3.4/tools/nlmtest'
Making check in mountstats
make[2]: Entering directory '/build/nfs-utils-2.3.4/tools/mountstats'
make[2]: Nothing to be done for 'check'.
make[2]: Leaving directory '/build/nfs-utils-2.3.4/tools/mountstats'
Making check in nfs-iostat
make[2]: Entering directory '/build/nfs-utils-2.3.4/tools/nfs-iostat'
make[2]: Nothing to be done for 'check'.
make[2]: Leaving directory '/build/nfs-utils-2.3.4/tools/nfs-iostat'
Making check in nfsconf
make[2]: Entering directory '/build/nfs-utils-2.3.4/tools/nfsconf'
make[2]: Nothing to be done for 'check'.
make[2]: Leaving directory '/build/nfs-utils-2.3.4/tools/nfsconf'
make[2]: Entering directory '/build/nfs-utils-2.3.4/tools'
make[2]: Nothing to be done for 'check-am'.
make[2]: Leaving directory '/build/nfs-utils-2.3.4/tools'
make[1]: Leaving directory '/build/nfs-utils-2.3.4/tools'
Making check in utils
make[1]: Entering directory '/build/nfs-utils-2.3.4/utils'
Making check in exportfs
make[2]: Entering directory '/build/nfs-utils-2.3.4/utils/exportfs'
make[2]: Nothing to be done for 'check'.
make[2]: Leaving directory '/build/nfs-utils-2.3.4/utils/exportfs'
Making check in mountd
make[2]: Entering directory '/build/nfs-utils-2.3.4/utils/mountd'
make[2]: Nothing to be done for 'check'.
make[2]: Leaving directory '/build/nfs-utils-2.3.4/utils/mountd'
Making check in nfsd
make[2]: Entering directory '/build/nfs-utils-2.3.4/utils/nfsd'
make[2]: Nothing to be done for 'check'.
make[2]: Leaving directory '/build/nfs-utils-2.3.4/utils/nfsd'
Making check in nfsstat
make[2]: Entering directory '/build/nfs-utils-2.3.4/utils/nfsstat'
make[2]: Nothing to be done for 'check'.
make[2]: Leaving directory '/build/nfs-utils-2.3.4/utils/nfsstat'
Making check in showmount
make[2]: Entering directory '/build/nfs-utils-2.3.4/utils/showmount'
make[2]: Nothing to be done for 'check'.
make[2]: Leaving directory '/build/nfs-utils-2.3.4/utils/showmount'
Making check in statd
make[2]: Entering directory '/build/nfs-utils-2.3.4/utils/statd'
make  check-am
make[3]: Entering directory '/build/nfs-utils-2.3.4/utils/statd'
make[3]: Nothing to be done for 'check-am'.
make[3]: Leaving directory '/build/nfs-utils-2.3.4/utils/statd'
make[2]: Leaving directory '/build/nfs-utils-2.3.4/utils/statd'
Making check in idmapd
make[2]: Entering directory '/build/nfs-utils-2.3.4/utils/idmapd'
make[2]: Nothing to be done for 'check'.
make[2]: Leaving directory '/build/nfs-utils-2.3.4/utils/idmapd'
Making check in nfsidmap
make[2]: Entering directory '/build/nfs-utils-2.3.4/utils/nfsidmap'
make[2]: Nothing to be done for 'check'.
make[2]: Leaving directory '/build/nfs-utils-2.3.4/utils/nfsidmap'
Making check in blkmapd
make[2]: Entering directory '/build/nfs-utils-2.3.4/utils/blkmapd'
make[2]: Nothing to be done for 'check'.
make[2]: Leaving directory '/build/nfs-utils-2.3.4/utils/blkmapd'
Making check in gssd
make[2]: Entering directory '/build/nfs-utils-2.3.4/utils/gssd'
make[2]: Nothing to be done for 'check'.
make[2]: Leaving directory '/build/nfs-utils-2.3.4/utils/gssd'
Making check in mount
make[2]: Entering directory '/build/nfs-utils-2.3.4/utils/mount'
make[2]: Nothing to be done for 'check'.
make[2]: Leaving directory '/build/nfs-utils-2.3.4/utils/mount'
Making check in nfsdcld
make[2]: Entering directory '/build/nfs-utils-2.3.4/utils/nfsdcld'
make[2]: Nothing to be done for 'check'.
make[2]: Leaving directory '/build/nfs-utils-2.3.4/utils/nfsdcld'
Making check in nfsdcltrack
make[2]: Entering directory '/build/nfs-utils-2.3.4/utils/nfsdcltrack'
make[2]: Nothing to be done for 'check'.
make[2]: Leaving directory '/build/nfs-utils-2.3.4/utils/nfsdcltrack'
make[2]: Entering directory '/build/nfs-utils-2.3.4/utils'
make[2]: Nothing to be done for 'check-am'.
make[2]: Leaving directory '/build/nfs-utils-2.3.4/utils'
make[1]: Leaving directory '/build/nfs-utils-2.3.4/utils'
Making check in linux-nfs
make[1]: Entering directory '/build/nfs-utils-2.3.4/linux-nfs'
make[1]: Nothing to be done for 'check'.
make[1]: Leaving directory '/build/nfs-utils-2.3.4/linux-nfs'
Making check in tests
make[1]: Entering directory '/build/nfs-utils-2.3.4/tests'
Making check in nsm_client
make[2]: Entering directory '/build/nfs-utils-2.3.4/tests/nsm_client'
make  check-am
make[3]: Entering directory '/build/nfs-utils-2.3.4/tests/nsm_client'
make  nsm_client
make[4]: Entering directory '/build/nfs-utils-2.3.4/tests/nsm_client'
gcc -DHAVE_CONFIG_H -I. -I../../support/include  -I/nix/store/g7npajykv5j=
rap80a1ldsnmvr4lyr7ap-libtirpc-1.1.4-dev/include/tirpc -D_GNU_SOURCE -pip=
e  -Wall  -Wextra  -Werror=3Dstrict-prototypes  -Werror=3Dmissing-prototy=
pes  -Werror=3Dmissing-declarations  -Werror=3Dformat=3D2  -Werror=3Dunde=
f  -Werror=3Dmissing-include-dirs  -Werror=3Dstrict-aliasing=3D2  -Werror=
=3Dinit-self  -Werror=3Dimplicit-function-declaration  -Werror=3Dreturn-t=
ype  -Werror=3Dswitch  -Werror=3Doverflow  -Werror=3Dparentheses  -Werror=
=3Daggregate-return  -Werror=3Dunused-result  -Wno-cast-function-type  -f=
no-strict-aliasing  -Werror=3Dformat-overflow=3D2 -Werror=3Dint-conversio=
n -Werror=3Dincompatible-pointer-types -Werror=3Dmisleading-indentation -=
g -O2 -c -o nlm_sm_inter_clnt.o nlm_sm_inter_clnt.c
gcc -DHAVE_CONFIG_H -I. -I../../support/include  -I/nix/store/g7npajykv5j=
rap80a1ldsnmvr4lyr7ap-libtirpc-1.1.4-dev/include/tirpc -D_GNU_SOURCE -pip=
e  -Wall  -Wextra  -Werror=3Dstrict-prototypes  -Werror=3Dmissing-prototy=
pes  -Werror=3Dmissing-declarations  -Werror=3Dformat=3D2  -Werror=3Dunde=
f  -Werror=3Dmissing-include-dirs  -Werror=3Dstrict-aliasing=3D2  -Werror=
=3Dinit-self  -Werror=3Dimplicit-function-declaration  -Werror=3Dreturn-t=
ype  -Werror=3Dswitch  -Werror=3Doverflow  -Werror=3Dparentheses  -Werror=
=3Daggregate-return  -Werror=3Dunused-result  -Wno-cast-function-type  -f=
no-strict-aliasing  -Werror=3Dformat-overflow=3D2 -Werror=3Dint-conversio=
n -Werror=3Dincompatible-pointer-types -Werror=3Dmisleading-indentation -=
g -O2 -c -o nlm_sm_inter_svc.o nlm_sm_inter_svc.c
nlm_sm_inter_svc.c:20:1: warning: no previous prototype for 'nlm_sm_prog_=
3' [-Wmissing-prototypes]
 nlm_sm_prog_3(struct svc_req *rqstp, register SVCXPRT *transp)
 ^~~~~~~~~~~~~
nlm_sm_inter_svc.c:61:1: warning: no previous prototype for 'nlm_sm_prog_=
4' [-Wmissing-prototypes]
 nlm_sm_prog_4(struct svc_req *rqstp, register SVCXPRT *transp)
 ^~~~~~~~~~~~~
cc1: warning: unrecognized command line option '-Wno-cast-function-type'
gcc -DHAVE_CONFIG_H -I. -I../../support/include  -I/nix/store/g7npajykv5j=
rap80a1ldsnmvr4lyr7ap-libtirpc-1.1.4-dev/include/tirpc -D_GNU_SOURCE -pip=
e  -Wall  -Wextra  -Werror=3Dstrict-prototypes  -Werror=3Dmissing-prototy=
pes  -Werror=3Dmissing-declarations  -Werror=3Dformat=3D2  -Werror=3Dunde=
f  -Werror=3Dmissing-include-dirs  -Werror=3Dstrict-aliasing=3D2  -Werror=
=3Dinit-self  -Werror=3Dimplicit-function-declaration  -Werror=3Dreturn-t=
ype  -Werror=3Dswitch  -Werror=3Doverflow  -Werror=3Dparentheses  -Werror=
=3Daggregate-return  -Werror=3Dunused-result  -Wno-cast-function-type  -f=
no-strict-aliasing  -Werror=3Dformat-overflow=3D2 -Werror=3Dint-conversio=
n -Werror=3Dincompatible-pointer-types -Werror=3Dmisleading-indentation -=
g -O2 -c -o nlm_sm_inter_xdr.o nlm_sm_inter_xdr.c
nlm_sm_inter_xdr.c: In function 'xdr_nlm_sm_notify':
nlm_sm_inter_xdr.c:13:6: warning: unused variable 'i' [-Wunused-variable]=

  int i;
      ^
nlm_sm_inter_xdr.c:11:20: warning: unused variable 'buf' [-Wunused-variab=
le]
  register int32_t *buf;
                    ^~~
nlm_sm_inter_xdr.c: At top level:
cc1: warning: unrecognized command line option '-Wno-cast-function-type'
gcc -DHAVE_CONFIG_H -I. -I../../support/include  -I/nix/store/g7npajykv5j=
rap80a1ldsnmvr4lyr7ap-libtirpc-1.1.4-dev/include/tirpc -D_GNU_SOURCE -pip=
e  -Wall  -Wextra  -Werror=3Dstrict-prototypes  -Werror=3Dmissing-prototy=
pes  -Werror=3Dmissing-declarations  -Werror=3Dformat=3D2  -Werror=3Dunde=
f  -Werror=3Dmissing-include-dirs  -Werror=3Dstrict-aliasing=3D2  -Werror=
=3Dinit-self  -Werror=3Dimplicit-function-declaration  -Werror=3Dreturn-t=
ype  -Werror=3Dswitch  -Werror=3Doverflow  -Werror=3Dparentheses  -Werror=
=3Daggregate-return  -Werror=3Dunused-result  -Wno-cast-function-type  -f=
no-strict-aliasing  -Werror=3Dformat-overflow=3D2 -Werror=3Dint-conversio=
n -Werror=3Dincompatible-pointer-types -Werror=3Dmisleading-indentation -=
g -O2 -c -o nsm_client.o nsm_client.c
nsm_client.c: In function 'hex2bin':
nsm_client.c:104:24: warning: comparison between signed and unsigned inte=
ger expressions [-Wsign-compare]
  for (i =3D 0; *src && i < dstlen; i++) {
                        ^
nsm_client.c: In function 'bin2hex':
nsm_client.c:122:16: warning: comparison between signed and unsigned inte=
ger expressions [-Wsign-compare]
  for (i =3D 0; i < srclen; i++)
                ^
nsm_client.c: In function 'sim_killer':
nsm_client.c:430:28: warning: unused parameter 'sig' [-Wunused-parameter]=

 static void sim_killer(int sig)
                            ^~~
nsm_client.c: In function 'nlm_sm_notify_4_svc':
nsm_client.c:450:71: warning: unused parameter 'rqstp' [-Wunused-paramete=
r]
 void *nlm_sm_notify_4_svc(struct nlm_sm_notify *argp, struct svc_req *rq=
stp)
                                                                       ^~=
~~~
nsm_client.c: In function 'main':
nsm_client.c:143:4: warning: this statement may fall through [-Wimplicit-=
fallthrough=3D]
    strncpy(host, optarg, sizeof(host));
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
nsm_client.c:144:3: note: here
   case 'n':
   ^~~~
nsm_client.c:145:4: warning: this statement may fall through [-Wimplicit-=
fallthrough=3D]
    strncpy(my_name, optarg, sizeof(my_name));
    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
nsm_client.c:146:3: note: here
   case 'P':
   ^~~~
nsm_client.c:147:12: warning: this statement may fall through [-Wimplicit=
-fallthrough=3D]
    my_prog =3D atoi(optarg);
    ~~~~~~~~^~~~~~~~~~~~~~
nsm_client.c:148:3: note: here
   case 'v':
   ^~~~
nsm_client.c: At top level:
cc1: warning: unrecognized command line option '-Wno-cast-function-type'
/nix/store/x0mlaj4z4ciycaycfwc36l1932mwywfj-bash-4.4-p23/bin/bash ../../l=
ibtool  --tag=3DCC   --mode=3Dlink gcc -pipe  -Wall  -Wextra  -Werror=3Ds=
trict-prototypes  -Werror=3Dmissing-prototypes  -Werror=3Dmissing-declara=
tions  -Werror=3Dformat=3D2  -Werror=3Dundef  -Werror=3Dmissing-include-d=
irs  -Werror=3Dstrict-aliasing=3D2  -Werror=3Dinit-self  -Werror=3Dimplic=
it-function-declaration  -Werror=3Dreturn-type  -Werror=3Dswitch  -Werror=
=3Doverflow  -Werror=3Dparentheses  -Werror=3Daggregate-return  -Werror=3D=
unused-result  -Wno-cast-function-type  -fno-strict-aliasing  -Werror=3Df=
ormat-overflow=3D2 -Werror=3Dint-conversion -Werror=3Dincompatible-pointe=
r-types -Werror=3Dmisleading-indentation -g -O2   -o nsm_client nlm_sm_in=
ter_clnt.o nlm_sm_inter_svc.o nlm_sm_inter_xdr.o  nsm_client.o ../../supp=
ort/nfs/.libs/libnfs.a ../../support/nsm/libnsm.a -lcap -L/nix/store/6ab4=
zf1x3n5v8z4x7rzw166zyv4ygy67-libtirpc-1.1.4/lib -ltirpc -lresolv
libtool: link: gcc -pipe -Wall -Wextra -Werror=3Dstrict-prototypes -Werro=
r=3Dmissing-prototypes -Werror=3Dmissing-declarations -Werror=3Dformat=3D=
2 -Werror=3Dundef -Werror=3Dmissing-include-dirs -Werror=3Dstrict-aliasin=
g=3D2 -Werror=3Dinit-self -Werror=3Dimplicit-function-declaration -Werror=
=3Dreturn-type -Werror=3Dswitch -Werror=3Doverflow -Werror=3Dparentheses =
-Werror=3Daggregate-return -Werror=3Dunused-result -Wno-cast-function-typ=
e -fno-strict-aliasing -Werror=3Dformat-overflow=3D2 -Werror=3Dint-conver=
sion -Werror=3Dincompatible-pointer-types -Werror=3Dmisleading-indentatio=
n -g -O2 -o nsm_client nlm_sm_inter_clnt.o nlm_sm_inter_svc.o nlm_sm_inte=
r_xdr.o nsm_client.o  ../../support/nfs/.libs/libnfs.a ../../support/nsm/=
libnsm.a -lcap -L/nix/store/6ab4zf1x3n5v8z4x7rzw166zyv4ygy67-libtirpc-1.1=
=2E4/lib /nix/store/6ab4zf1x3n5v8z4x7rzw166zyv4ygy67-libtirpc-1.1.4/lib/l=
ibtirpc.so -lresolv -Wl,-rpath -Wl,/nix/store/6ab4zf1x3n5v8z4x7rzw166zyv4=
ygy67-libtirpc-1.1.4/lib -Wl,-rpath -Wl,/nix/store/6ab4zf1x3n5v8z4x7rzw16=
6zyv4ygy67-libtirpc-1.1.4/lib
make[4]: Leaving directory '/build/nfs-utils-2.3.4/tests/nsm_client'
make[3]: Leaving directory '/build/nfs-utils-2.3.4/tests/nsm_client'
make[2]: Leaving directory '/build/nfs-utils-2.3.4/tests/nsm_client'
make[2]: Entering directory '/build/nfs-utils-2.3.4/tests'
make  statdb_dump
make[3]: Entering directory '/build/nfs-utils-2.3.4/tests'
gcc -DHAVE_CONFIG_H -I. -I../support/include  -I/nix/store/g7npajykv5jrap=
80a1ldsnmvr4lyr7ap-libtirpc-1.1.4-dev/include/tirpc -D_GNU_SOURCE -pipe  =
-Wall  -Wextra  -Werror=3Dstrict-prototypes  -Werror=3Dmissing-prototypes=
  -Werror=3Dmissing-declarations  -Werror=3Dformat=3D2  -Werror=3Dundef  =
-Werror=3Dmissing-include-dirs  -Werror=3Dstrict-aliasing=3D2  -Werror=3D=
init-self  -Werror=3Dimplicit-function-declaration  -Werror=3Dreturn-type=
  -Werror=3Dswitch  -Werror=3Doverflow  -Werror=3Dparentheses  -Werror=3D=
aggregate-return  -Werror=3Dunused-result  -Wno-cast-function-type  -fno-=
strict-aliasing  -Werror=3Dformat-overflow=3D2 -Werror=3Dint-conversion -=
Werror=3Dincompatible-pointer-types -Werror=3Dmisleading-indentation -g -=
O2 -c -o statdb_dump.o statdb_dump.c
statdb_dump.c: In function 'dump_host':
statdb_dump.c:38:17: warning: unused parameter 'timestamp' [-Wunused-para=
meter]
    const time_t timestamp)
                 ^~~~~~~~~
statdb_dump.c: In function 'main':
statdb_dump.c:91:10: warning: unused parameter 'argc' [-Wunused-parameter=
]
 main(int argc, char **argv)
          ^~~~
statdb_dump.c: At top level:
cc1: warning: unrecognized command line option '-Wno-cast-function-type'
/nix/store/x0mlaj4z4ciycaycfwc36l1932mwywfj-bash-4.4-p23/bin/bash ../libt=
ool  --tag=3DCC   --mode=3Dlink gcc -pipe  -Wall  -Wextra  -Werror=3Dstri=
ct-prototypes  -Werror=3Dmissing-prototypes  -Werror=3Dmissing-declaratio=
ns  -Werror=3Dformat=3D2  -Werror=3Dundef  -Werror=3Dmissing-include-dirs=
  -Werror=3Dstrict-aliasing=3D2  -Werror=3Dinit-self  -Werror=3Dimplicit-=
function-declaration  -Werror=3Dreturn-type  -Werror=3Dswitch  -Werror=3D=
overflow  -Werror=3Dparentheses  -Werror=3Daggregate-return  -Werror=3Dun=
used-result  -Wno-cast-function-type  -fno-strict-aliasing  -Werror=3Dfor=
mat-overflow=3D2 -Werror=3Dint-conversion -Werror=3Dincompatible-pointer-=
types -Werror=3Dmisleading-indentation -g -O2   -o statdb_dump statdb_dum=
p.o ../support/nfs/.libs/libnfs.a ../support/nsm/libnsm.a -lcap -lresolv
libtool: link: gcc -pipe -Wall -Wextra -Werror=3Dstrict-prototypes -Werro=
r=3Dmissing-prototypes -Werror=3Dmissing-declarations -Werror=3Dformat=3D=
2 -Werror=3Dundef -Werror=3Dmissing-include-dirs -Werror=3Dstrict-aliasin=
g=3D2 -Werror=3Dinit-self -Werror=3Dimplicit-function-declaration -Werror=
=3Dreturn-type -Werror=3Dswitch -Werror=3Doverflow -Werror=3Dparentheses =
-Werror=3Daggregate-return -Werror=3Dunused-result -Wno-cast-function-typ=
e -fno-strict-aliasing -Werror=3Dformat-overflow=3D2 -Werror=3Dint-conver=
sion -Werror=3Dincompatible-pointer-types -Werror=3Dmisleading-indentatio=
n -g -O2 -o statdb_dump statdb_dump.o  ../support/nfs/.libs/libnfs.a ../s=
upport/nsm/libnsm.a -lcap -lresolv
/nix/store/2dfjlvp38xzkyylwpavnh61azi0d168b-binutils-2.31.1/bin/ld: ../su=
pport/nsm/libnsm.a(file.o): in function `nsm_make_pathname':
/build/nfs-utils-2.3.4/support/nsm/file.c:174: undefined reference to `ge=
neric_make_pathname'
/nix/store/2dfjlvp38xzkyylwpavnh61azi0d168b-binutils-2.31.1/bin/ld: /buil=
d/nfs-utils-2.3.4/support/nsm/file.c:174: undefined reference to `generic=
_make_pathname'
/nix/store/2dfjlvp38xzkyylwpavnh61azi0d168b-binutils-2.31.1/bin/ld: /buil=
d/nfs-utils-2.3.4/support/nsm/file.c:174: undefined reference to `generic=
_make_pathname'
/nix/store/2dfjlvp38xzkyylwpavnh61azi0d168b-binutils-2.31.1/bin/ld: ../su=
pport/nsm/libnsm.a(file.o): in function `nsm_setup_pathnames':
/build/nfs-utils-2.3.4/support/nsm/file.c:279: undefined reference to `ge=
neric_setup_basedir'
collect2: error: ld returned 1 exit status


--------------7426ECB91D08A2392B66C2C0--
