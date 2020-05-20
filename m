Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA4771DBA88
	for <lists+linux-nfs@lfdr.de>; Wed, 20 May 2020 19:04:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgETRDi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Wed, 20 May 2020 13:03:38 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55298 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727847AbgETRDg (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Wed, 20 May 2020 13:03:36 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04KH1Uvg074993;
        Wed, 20 May 2020 17:03:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc : subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=Wfz6Oxn8u0ZQPtJGWQThIn2b8qrzFZJTaUG3oRYS3Zo=;
 b=rAij2M393fgwDu8YHh/G8HvxR0cBpyR2I/ADJokInC5Hf8QalekHF9tZRq6nnxH5CXYO
 NhiMjU79V2jPLvI4C/eaWme+IqeZNZXtTJ9nxQ/SpyxylSIT5+Jcmu1dZcTTQQ3+O4t6
 couKF265DIl1sGVHGr2/jZsBEaNOLBIH1sGW+b/5pMBVJznidzPtP/OcbyhXVcZFriUS
 xre5GCMjyT6uh79uG8JB8/w4mKTHGo6ompNVdgzDXnQVjAS9zMFi0tqFhILWzGsJQix+
 nq1K2zRVkhfmP1U3ZdAdlydTKe9TdE9KJKNOHaeL0QlufyAWA2T6xEAPQWfxCtWvtyEl eQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 31501rau5b-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 20 May 2020 17:03:31 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04KGsgBY163823;
        Wed, 20 May 2020 17:01:31 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 314gm7d8a6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 May 2020 17:01:31 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04KH1UZa006502;
        Wed, 20 May 2020 17:01:30 GMT
Received: from mbp2018.cdmnet.org (/82.27.120.181)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 20 May 2020 10:01:30 -0700
Cc:     Calum Mackay <calum.mackay@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-rdma@vger.kernel.org
Subject: Re: [PATCH v2 00/29] Possible NFSD patches for v5.8
To:     Bruce Fields <bfields@fieldses.org>,
        Chuck Lever <chuck.lever@oracle.com>
References: <20200512211640.5826.77139.stgit@klimt.1015granger.net>
 <20200519161108.GD25858@fieldses.org>
 <81E97D7E-7B8D-4C64-844A-18EF0346C49C@oracle.com>
 <20200519212938.GG25858@fieldses.org>
 <470B6839-FBC6-49BA-B633-DD49D271FD42@oracle.com>
 <000ED881-6724-46EE-894E-57CD6DE10A15@oracle.com>
 <20200520164639.GA19305@fieldses.org>
From:   Calum Mackay <calum.mackay@oracle.com>
Organization: Oracle
Message-ID: <1af614e5-9784-cb5e-52a6-dc13b1d04524@oracle.com>
Date:   Wed, 20 May 2020 18:01:27 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.0a1
MIME-Version: 1.0
In-Reply-To: <20200520164639.GA19305@fieldses.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9627 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 phishscore=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005200136
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9627 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=999 clxscore=1011 priorityscore=1501 cotscore=-2147483648
 impostorscore=0 bulkscore=0 adultscore=0 malwarescore=0 phishscore=0
 mlxscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2005200137
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

hi Bruce,

…

On 20/05/2020 5:46 pm, Bruce Fields wrote:
> On Tue, May 19, 2020 at 07:32:37PM -0400, Chuck Lever wrote:
>> Looks like python3 is now a requirement for pynfs, despite the comments
>> and code in nfs4.0/testserver.py.
>>
>> Also, the README should explain that the server under test has to permit
>> access from insecure source ports (this still might not be the default
>> for some NFS servers).
> 
> Both done, thanks for the feedback.--b.
> 
> commit e4379b69becd
> Author: J. Bruce Fields <bfields@redhat.com>
> Date:   Wed May 20 12:43:33 2020 -0400
> 
>      Document high-port requirement for server testing
>      
>      Some NFS servers by default require the client to connect from a
>      low-numbered port.  But pynfs is meant to be runnable as a non-root
>      user, and as such can't necessarily get low-numbered ports.
>      
>      It might be useful to at least try to get a low-numbered port, or to
>      give a better error message.  For now, at least warn about this in the
>      README.
>      
>      Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> 
> diff --git a/README b/README
> index 79cac62cb75e..a0236fb6b209 100644
> --- a/README
> +++ b/README
> @@ -18,6 +18,10 @@ For more details about 4.0 and 4.1 testing, see nfs4.0/README and
>   nfs4.1/README, respectively.  For information about automatic code
>   generation from an XDR file, see xdr/README.
>   
> +Note that any server under test must permit connections from high port
> +numbers.  (In the case of the NFS server, you can do this by adding
> +"insecure" to the export options.)
> +
>   Note that test results should *not* be considered authoritative
>   statements about the protocol--if you find that a server fails a test,
>   you should consult the rfc's and think carefully before assuming that
> 
> commit 39b62e990d84
> Author: J. Bruce Fields <bfields@redhat.com>
> Date:   Tue May 19 22:58:23 2020 -0400
> 
>      Fix comments and version checks that refer to python 2
>      
>      The minimum required version may actually be greater than 3.0, I'm not
>      sure.

for what it's worth, it requires at least v3.2, since it uses 
os.fsencode(), which was introduced in that rev.

That doesn't contradict your statement, of course, and I've not checked 
the rest of it.

cheers,
calum.


>      
>      Signed-off-by: J. Bruce Fields <bfields@redhat.com>
> 
> diff --git a/nfs4.0/lib/rpc/rpc.py b/nfs4.0/lib/rpc/rpc.py
> index cc509965f8e7..8f5ce26226d3 100644
> --- a/nfs4.0/lib/rpc/rpc.py
> +++ b/nfs4.0/lib/rpc/rpc.py
> @@ -1,6 +1,6 @@
>   # rpc.py - based on RFC 1831
>   #
> -# Requires python 2.7
> +# Requires python 3
>   #
>   # Written by Fred Isaman <iisaman@citi.umich.edu>
>   # Copyright (C) 2004 University of Michigan, Center for
> diff --git a/nfs4.0/nfs4client.py b/nfs4.0/nfs4client.py
> index 5916dcc74139..37fbcbec9132 100755
> --- a/nfs4.0/nfs4client.py
> +++ b/nfs4.0/nfs4client.py
> @@ -9,8 +9,8 @@
>   #
>   
>   import sys
> -if sys.hexversion < 0x02070000:
> -    print("Requires python 2.7 or higher")
> +if sys.hexversion < 0x03000000:
> +    print("Requires python 3.0 or higher")
>       sys.exit(1)
>   import os
>   # Allow to be run stright from package root
> diff --git a/nfs4.0/nfs4lib.py b/nfs4.0/nfs4lib.py
> index 9adeb81daa95..82cec4b68cee 100644
> --- a/nfs4.0/nfs4lib.py
> +++ b/nfs4.0/nfs4lib.py
> @@ -1,7 +1,7 @@
>   #!/usr/bin/env python
>   # nfs4lib.py - NFS4 library for Python
>   #
> -# Requires python 2.7
> +# Requires python 3
>   #
>   # Written by Fred Isaman <iisaman@citi.umich.edu>
>   # Copyright (C) 2004 University of Michigan, Center for
> diff --git a/nfs4.0/servertests/environment.py b/nfs4.0/servertests/environment.py
> index e7ef2b052833..edbd37a638a5 100644
> --- a/nfs4.0/servertests/environment.py
> +++ b/nfs4.0/servertests/environment.py
> @@ -1,7 +1,7 @@
>   #
>   # environment.py
>   #
> -# Requires python 2.7
> +# Requires python 3
>   #
>   # Written by Fred Isaman <iisaman@citi.umich.edu>
>   # Copyright (C) 2004 University of Michigan, Center for
> diff --git a/nfs4.0/testserver.py b/nfs4.0/testserver.py
> index 4f31f92a1e34..d380f2d5fe83 100755
> --- a/nfs4.0/testserver.py
> +++ b/nfs4.0/testserver.py
> @@ -1,7 +1,7 @@
>   #!/usr/bin/env python
>   # nfs4stest.py - nfsv4 server tester
>   #
> -# Requires python 2.7
> +# Requires python 3
>   #
>   # Written by Fred Isaman <iisaman@citi.umich.edu>
>   # Copyright (C) 2004 University of Michigan, Center for
> @@ -26,8 +26,8 @@
>   
>   
>   import sys
> -if sys.hexversion < 0x02070000:
> -    print("Requires python 2.7 or higher")
> +if sys.hexversion < 0x03000000:
> +    print("Requires python 3.0 or higher")
>       sys.exit(1)
>   import os
>   # Allow to be run stright from package root
> diff --git a/nfs4.1/client41tests/environment.py b/nfs4.1/client41tests/environment.py
> index 25e7cb08ebb1..26d7368ebcb0 100644
> --- a/nfs4.1/client41tests/environment.py
> +++ b/nfs4.1/client41tests/environment.py
> @@ -1,7 +1,7 @@
>   #
>   # environment.py
>   #
> -# Requires python 2.7
> +# Requires python 3
>   #
>   # Written by Fred Isaman <iisaman@citi.umich.edu>
>   # Copyright (C) 2004 University of Michigan, Center for
> diff --git a/nfs4.1/server41tests/environment.py b/nfs4.1/server41tests/environment.py
> index e7bcaa90904c..b24862b61f08 100644
> --- a/nfs4.1/server41tests/environment.py
> +++ b/nfs4.1/server41tests/environment.py
> @@ -1,7 +1,7 @@
>   #
>   # environment.py
>   #
> -# Requires python 2.7
> +# Requires python 3
>   #
>   # Written by Fred Isaman <iisaman@citi.umich.edu>
>   # Copyright (C) 2004 University of Michigan, Center for
> diff --git a/nfs4.1/testclient.py b/nfs4.1/testclient.py
> index 19bd148edde2..3027419babd2 100755
> --- a/nfs4.1/testclient.py
> +++ b/nfs4.1/testclient.py
> @@ -1,7 +1,7 @@
>   #!/usr/bin/env python
>   # nfs4stest.py - nfsv4 server tester
>   #
> -# Requires python 2.7
> +# Requires python 3
>   #
>   # Written by Fred Isaman <iisaman@citi.umich.edu>
>   # Copyright (C) 2004 University of Michigan, Center for
> @@ -23,8 +23,8 @@
>   
>   import use_local # HACK so don't have to rebuild constantly
>   import sys
> -if sys.hexversion < 0x02070000:
> -    print("Requires python 2.7 or higher")
> +if sys.hexversion < 0x03000000:
> +    print("Requires python 3.0 or higher")
>       sys.exit(1)
>   import os
>   
> diff --git a/nfs4.1/testmod.py b/nfs4.1/testmod.py
> index 8c4ccdef5afa..0bf6bfc80fdc 100644
> --- a/nfs4.1/testmod.py
> +++ b/nfs4.1/testmod.py
> @@ -1,6 +1,6 @@
>   # testmod.py - run tests from a suite
>   #
> -# Requires python 2.7
> +# Requires python 3
>   #
>   # Written by Fred Isaman <iisaman@citi.umich.edu>
>   # Copyright (C) 2004 University of Michigan, Center for
> diff --git a/nfs4.1/testserver.py b/nfs4.1/testserver.py
> index f3fcfe9b8851..6b1157985be9 100755
> --- a/nfs4.1/testserver.py
> +++ b/nfs4.1/testserver.py
> @@ -1,7 +1,7 @@
>   #!/usr/bin/env python
>   # nfs4stest.py - nfsv4 server tester
>   #
> -# Requires python 2.7
> +# Requires python 3
>   #
>   # Written by Fred Isaman <iisaman@citi.umich.edu>
>   # Copyright (C) 2004 University of Michigan, Center for
> @@ -27,8 +27,8 @@
>   
>   import use_local # HACK so don't have to rebuild constantly
>   import sys
> -if sys.hexversion < 0x02070000:
> -    print("Requires python 2.7 or higher")
> +if sys.hexversion < 0x03000000:
> +    print("Requires python 3.0 or higher")
>       sys.exit(1)
>   import os
>   
> diff --git a/showresults.py b/showresults.py
> index 0229a1e4d7b6..41d1c851721c 100755
> --- a/showresults.py
> +++ b/showresults.py
> @@ -1,7 +1,7 @@
>   #!/usr/bin/env python
>   # showresults.py - redisplay results from nfsv4 server tester output file
>   #
> -# Requires python 2.7
> +# Requires python 3
>   #
>   # Written by Fred Isaman <iisaman@citi.umich.edu>
>   # Copyright (C) 2004 University of Michigan, Center for
> 

-- 
Calum Mackay
Linux Kernel Engineering
Oracle Linux and Virtualisation
