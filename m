Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 285641CCC92
	for <lists+linux-nfs@lfdr.de>; Sun, 10 May 2020 19:16:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728856AbgEJRQi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Sun, 10 May 2020 13:16:38 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47860 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728849AbgEJRQi (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Sun, 10 May 2020 13:16:38 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04AHDiwS105966;
        Sun, 10 May 2020 17:16:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=content-type :
 mime-version : subject : from : in-reply-to : date : cc :
 content-transfer-encoding : message-id : references : to;
 s=corp-2020-01-29; bh=vJ6EPBgkquPc2F+wTh8M5NkC0o+B1r0V8w34Dc7inPs=;
 b=sFiYiU2Th4LcC5cf1vEDMA8TiVIUiytb2BNt6Gtp37c24wSKCXqa2m4bO78P4kTJH2QW
 v6HjzR0AkesZHKbi2J7GO/RA/sR8jmgk6SpimXF5RhEzywS8rjKj6B6fzoTCnvtBROFu
 f/25qc04aeANMYSpSCxVBYVKIsTbepS6O3j9KblU+BOpsP8/LX2y8IEFpQaTMsPqr9Fo
 sf59jhbcdyfyyVT/3BXZqCGq8HcL0T9PdRrKIjoDMvhJBgemwmEC77D4d7iPJSvOdqdj
 A22s3r3MfCtYiEj0B7kybeeaR2yAQTCtXjGhTUodpiLAKjfa50bmRYju9ZqSaAcV9V1B 7g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 30x3mbhttd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sun, 10 May 2020 17:16:26 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04AHDmWf167371;
        Sun, 10 May 2020 17:16:26 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 30x6eu93vh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 10 May 2020 17:16:26 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 04AHGOOs010908;
        Sun, 10 May 2020 17:16:25 GMT
Received: from anon-dhcp-153.1015granger.net (/68.61.232.219)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sun, 10 May 2020 10:16:24 -0700
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.11\))
Subject: Re: [PATCH] nfs-utils: add new tool nfsd4-show to parse output from
 proc files
From:   Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <CALF+zOnSSDVHSmTgjGRuraL87fcZw=iEGzopKmceyyuHjX-YGQ@mail.gmail.com>
Date:   Sun, 10 May 2020 13:16:23 -0400
Cc:     Steve Dickson <SteveD@redhat.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        Bruce Fields <bfields@fieldses.org>,
        Kenneth Dsouza <kdsouza@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <F4C0A602-08D3-43C8-9E2C-11D8C3ED7847@oracle.com>
References: <20200428165142.GA1392654@nevermore.foobar.lan>
 <19946bbc-6612-3f5c-d9b4-f6de541cf8e7@RedHat.com>
 <CALF+zOnSSDVHSmTgjGRuraL87fcZw=iEGzopKmceyyuHjX-YGQ@mail.gmail.com>
To:     David Wysochanski <dwysocha@redhat.com>,
        Achilles Gaikwad <agaikwad@redhat.com>
X-Mailer: Apple Mail (2.3445.104.11)
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9617 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 phishscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005100160
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9617 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 impostorscore=0
 mlxscore=0 suspectscore=0 bulkscore=0 mlxlogscore=999 phishscore=0
 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005100160
Sender: linux-nfs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On May 10, 2020, at 1:09 PM, David Wysochanski <dwysocha@redhat.com> =
wrote:
>=20
> On Fri, May 8, 2020 at 1:01 PM Steve Dickson <SteveD@redhat.com> =
wrote:
>>=20
>> Hello,
>>=20
>> On 4/28/20 12:51 PM, Achilles Gaikwad wrote:
>>> This tool parses the output from the following files
>>>=20
>>> /proc/fs/nfsd/clients/*/{states,info}
>>>=20
>>> - Tool has the following parameters so far:
>> This is looking very good! A couple things....
>>=20
>> A man page is needed and what do you think about
>> changing the name to nfsdclts? I realize only v4
>> clients will be shown but that's a doc issue imho.
>>=20
>> Basically I'm trying to some type of command name convention
>>=20
>=20
> Is there any precedence for 'clts' or was this just an attempt to
> shorten the name?

I'm also uncomfortable with the proposed name of this tool.


> Maybe the closest near examples in nfs-utils for tools are:
> nfsdcltrack - NFSv4 Client Tracking Callout Program
> nfsdcld - NFSv4 Client Tracking Daemon
>=20
> For naming maybe 'cl'<something> is consistent?
> With that them, two possible names for this tool would be:
> nfsdclinfo
> nfsdclshow
>=20
> I almost said 'nfsdclstats' because this is somewhat like a nfs =
server.
> There's 'mountstats' for client side - is this somewhat a server side
> equivalent?
> Not really since 'stats' implies numbers and there's not a lot of that =
here.
>=20
> FWIW, I also thought nfsd4-show was ok, but it seems to be a new =
naming format.
>=20
>=20
>> BTW, I'm thinking this is going to be a very useful tool!
>> Nice work!
>>=20
>> steved.
>>=20
>>>=20
>>> ~~~
>>> $ /usr/sbin/nfsd4-show -h
>>> usage: nfsd4-show [-h] [-t type] [--clientinfo] [--hostname] [-q]
>>>=20
>>> Parse the nfsd states and clientinfo files.
>>>=20
>>> optional arguments:
>>>  -h, --help            show this help message and exit
>>>  -t type, --type type  Input the type that you want to be printed: =
open,
>>>                        lock, deleg, layout, all
>>>  --clientinfo          output clients information, --hostname is =
implied.
>>>  --hostname            print hostname of client instead of its ip =
address.
>>>                        Longer hostnames are truncated.
>>>  -q, --quiet           don't print the header information
>>> ~~~
>>>=20
>>> - This tool enables the output to have both ip address and =
filaname[1]
>>>=20
>>> ~~~
>>> Inode number | Type   | ip address            | Filename
>>> 33811576     | lock   | [::1]:682             | foobar
>>> ~~~
>>>=20
>>> - You can also display just the open files
>>>=20
>>> ~~~
>>> Inode number | Type   | Access | Deny | ip address            | =
Filename
>>> :::
>>> 226493407    | open   | r-     | --   | 10.65.211.137:708     | 999
>>> 226493409    | open   | r-     | --   | 10.65.211.137:708     | ff
>>> 226493410    | open   | r-     | --   | 10.65.211.137:708     | foo
>>> 226493413    | open   | r-     | --   | 10.65.211.137:708     | =
open_lock.py
>>> 33811575     | open   | r-     | --   | [::1]:682             | file
>>> 33811576     | open   | rw     | --   | [::1]:682             | =
foobar
>>> :::
>>> ~~~
>>>=20
>>> - Handles disconnected dentries from userspace by showing filename =
as :
>>>=20
>>> ~~~
>>> Inode number | Type   | Access | Deny | ip address            | =
Filename
>>> :::
>>> 226493409    | open   | r-     | --   | 10.65.211.66:867      | =
disconnected dentry
>>> 226493409    | deleg  | r      |      | 10.65.211.66:867      | =
disconnected dentry
>>> 226493410    | open   | r-     | --   | 10.65.211.66:867      | =
disconnected dentry
>>> 226493410    | deleg  | r      |      | 10.65.211.66:867      | =
disconnected dentry
>>> ~~~
>>>=20
>>> - Automatically drop the deny column for delegation
>>>=20
>>> ~~~
>>> Inode number | Type   | Access | ip address            | Filename
>>> 226726004    | deleg  | r      | 10.65.211.137:708     | foo
>>> 226726013    | deleg  | r      | 10.65.211.137:708     | bar
>>> ~~~
>>>=20
>>> - clientinfo would show the version of nfs that the client has =
mounted the share with
>>>=20
>>>  the client id.
>>>=20
>>> ~~~
>>> Inode number | Type   | Access | Deny | ip address            | =
Client ID           | vers | Filename
>>> 226726004    | open   | r-     | --   | 10.65.211.137:708     | =
0xf2924e155ea84ae8  | 4.2  | foo
>>> 226726004    | deleg  | r      |      | 10.65.211.137:708     | =
0xf2924e155ea84ae8  | 4.2  | foo
>>> ~~~
>>>=20
>>> - hostname option would show the hostname instead of ip addresses
>>>=20
>>> ~~~
>>> Inode number | Type   | Access | Deny | Hostname              | =
Filename
>>> 227054876    | open   | r-     | --   | vm137                 | =
fubar
>>> ~~~
>>>=20
>>> If you do not like the header, please use the -q option.
>>>=20
>>> Your feedback and review is highly apprecaited!
>>>=20
>>> You will need the following patch for filename to be displayed:
>>> [1] https://www.spinics.net/lists/linux-nfs/msg77332.html
>>>=20
>>> Signed-off-by: Achilles Gaikwad <agaikwad@redhat.com>
>>> Signed-off-by: Kenneth D'souza <kdsouza@redhat.com>
>>> ---
>>> configure.ac                   |   1 +
>>> tools/Makefile.am              |   2 +-
>>> tools/nfsd4-show/Makefile.am   |   9 ++
>>> tools/nfsd4-show/nfsd4-show.py | 219 =
+++++++++++++++++++++++++++++++++
>>> 4 files changed, 230 insertions(+), 1 deletion(-)
>>> create mode 100644 tools/nfsd4-show/Makefile.am
>>> create mode 100755 tools/nfsd4-show/nfsd4-show.py
>>>=20
>>> diff --git a/configure.ac b/configure.ac
>>> index 00b32800..366f9b7c 100644
>>> --- a/configure.ac
>>> +++ b/configure.ac
>>> @@ -689,6 +689,7 @@ AC_CONFIG_FILES([
>>>      tools/rpcgen/Makefile
>>>      tools/mountstats/Makefile
>>>      tools/nfs-iostat/Makefile
>>> +     tools/nfsd4-show/Makefile
>>>      tools/nfsconf/Makefile
>>>      tools/clddb-tool/Makefile
>>>      utils/Makefile
>>> diff --git a/tools/Makefile.am b/tools/Makefile.am
>>> index 53e61170..3cebbe95 100644
>>> --- a/tools/Makefile.am
>>> +++ b/tools/Makefile.am
>>> @@ -12,6 +12,6 @@ if CONFIG_NFSDCLD
>>> OPTDIRS +=3D clddb-tool
>>> endif
>>>=20
>>> -SUBDIRS =3D locktest rpcdebug nlmtest mountstats nfs-iostat =
$(OPTDIRS)
>>> +SUBDIRS =3D nfsd4-show locktest rpcdebug nlmtest mountstats =
nfs-iostat $(OPTDIRS)
>>>=20
>>> MAINTAINERCLEANFILES =3D Makefile.in
>>> diff --git a/tools/nfsd4-show/Makefile.am =
b/tools/nfsd4-show/Makefile.am
>>> new file mode 100644
>>> index 00000000..1b57cfb2
>>> --- /dev/null
>>> +++ b/tools/nfsd4-show/Makefile.am
>>> @@ -0,0 +1,9 @@
>>> +## Process this file with automake to produce Makefile.in
>>> +PYTHON_FILES =3D  nfsd4-show.py
>>> +
>>> +all-local: $(PYTHON_FILES)
>>> +
>>> +install-data-hook:
>>> +     $(INSTALL) -m 755 nfsd4-show.py =
$(DESTDIR)$(sbindir)/nfsd4-show
>>> +
>>> +MAINTAINERCLEANFILES=3DMakefile.in
>>> \ No newline at end of file
>>> diff --git a/tools/nfsd4-show/nfsd4-show.py =
b/tools/nfsd4-show/nfsd4-show.py
>>> new file mode 100755
>>> index 00000000..52775e66
>>> --- /dev/null
>>> +++ b/tools/nfsd4-show/nfsd4-show.py
>>> @@ -0,0 +1,219 @@
>>> +#!/bin/python3
>>> +# -*- python-mode -*-
>>> +'''
>>> +    Copyright (C) 2020
>>> +    Authors:    Achilles Gaikwad <agaikwad@redhat.com>
>>> +                Kenneth  D'souza <kdsouza@redhat.com>
>>> +
>>> +    This program is free software: you can redistribute it and/or =
modify
>>> +    it under the terms of the GNU General Public License as =
published by
>>> +    the Free Software Foundation, either version 3 of the License, =
or
>>> +    (at your option) any later version.
>>> +
>>> +    This program is distributed in the hope that it will be useful,
>>> +    but WITHOUT ANY WARRANTY; without even the implied warranty of
>>> +    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
>>> +    GNU General Public License for more details.
>>> +
>>> +    You should have received a copy of the GNU General Public =
License
>>> +    along with this program.  If not, see =
<https://www.gnu.org/licenses/>.
>>> +'''
>>> +
>>> +import multiprocessing as mp
>>> +import os
>>> +import signal
>>> +import sys
>>> +
>>> +try:
>>> +    import argparse
>>> +except ImportError:
>>> +    print('%s:  Failed to import argparse - make sure argparse is =
installed!'
>>> +        % sys.argv[0])
>>> +    sys.exit(1)
>>> +try:
>>> +    import yaml
>>> +except ImportError:
>>> +    print('%s:  Failed to import yaml - make sure python3-pyyaml is =
installed!'
>>> +        % sys.argv[0])
>>> +    sys.exit(1)
>>> +
>>> +BBOLD =3D '\033[1;30;47m' #Bold black text with white background.
>>> +ENDC =3D '\033[m' #Rest to defaults
>>> +
>>> +def init_worker():
>>> +    signal.signal(signal.SIGINT, signal.SIG_IGN)
>>> +
>>> +# this function converts the info file to a dictionary format, =
sorta. :)
>>> +def file_to_dict(path):
>>> +    client_info =3D {}
>>> +    with open(path) as f:
>>> +        for line in f:
>>> +            try:
>>> +                (key, val) =3D line.split(':')
>>> +                client_info[key] =3D val
>>> +    # FIXME: There has to be a better way of converting tscrews he =
info file to a dictionary.
>>> +            except ValueError:
>>> +                try:
>>> +                    (key, val) =3D line.split()
>>> +                    client_info[key] =3D val
>>> +                except:
>>> +                    pass
>>> +    return client_info
>>> +
>>> +# this functino gets the paths from /proc/fs/nfsd/clients/
>>> +# returns a list of paths for each client which has nfs-share =
mounted.
>>> +def getpaths():
>>> +    path =3D []
>>> +    try:
>>> +        dirs =3D os.listdir('/proc/fs/nfsd/clients/')
>>> +    except OSError as reason:
>>> +        exit('%s' % reason)
>>> +    if len(dirs) !=3D0:
>>> +         for i in dirs:
>>> +                 path.append('/proc/fs/nfsd/clients/' + i + =
'/states')
>>> +         return (path)
>>> +    else:
>>> +         exit('Nothing to process')
>>> +
>>> +# A single function to rule them all, in this function we gather =
all the data
>>> +# from already populated data_list and client_info.
>>> +def printer(data_list, argument):
>>> +    client_info_path =3D data_list.pop()
>>> +    client_info =3D file_to_dict(client_info_path)
>>> +    for i in data_list:
>>> +        for key in i:
>>> +            inode =3D i[key]['superblock'].split(':')[-1]
>>> +            # get the ip address from client_info as 'address:' =
note the extra
>>> +            # ':' as a suffix to address. If there is a better way =
to convert
>>> +            # the file to dictionary, please change the following =
value too.
>>> +            client_ip =3D client_info['address:']
>>> +            # The ip address is quoted, so we dequote it.
>>> +            client_ip =3D client_ip[1:-1]
>>> +            try:
>>> +                # if the nfs-server reboots while the nfs-client =
holds the files open,
>>> +                # the nfs-server would print the filename as '/'. =
For such instaces we
>>> +                # print the output as disconnected dentry instead =
of '/'.
>>> +                if(i[key]['filename']=3D=3D'/'):
>>> +                    fname =3D 'disconnected dentry'
>>> +                else:
>>> +                    fname =3D i[key]['filename'].split('/')[-1]
>>> +            except KeyError:
>>> +                # for older kernels which do not have the fname =
patch in kernel, they
>>> +                # won't be able to see the fname field. Therefore =
post it as N/A.
>>> +                fname =3D "N/A"
>>> +            otype =3D i[key]['type']
>>> +            try:
>>> +                access =3D i[key]['access']
>>> +            except:
>>> +                access =3D ''
>>> +            try:
>>> +                deny =3D i[key]['deny']
>>> +            except:
>>> +                deny =3D ''
>>> +            hostname =3D =
client_info['name'].split()[-1].split('"')[0]
>>> +            hostname =3D  hostname.split('.')[0]
>>> +            otype =3D i[key]['type']
>>> +            # if the hostname is too long, it messes up with the =
output being in columns,
>>> +            # therefore we truncate the hostname followed by two =
'..' as suffix.
>>> +            if len(hostname) > 20:
>>> +                hostname =3D hostname[0:20] + '..'
>>> +            clientid =3D client_info['clientid'].strip()
>>> +            minorversion =3D client_info['minor =
version'].rstrip().rsplit()[0]
>>> +            # since some fields do not have deny column, we drop =
those if -t is either
>>> +            # layout or lock.
>>> +            drop =3D ['layout', 'lock']
>>> +
>>> +            # Printing the output this way instead of a single =
string which is concatenated
>>> +            # this makes it better to quickly add more columns in =
future.
>>> +            if(otype =3D=3D argument.type or  argument.type =3D=3D =
'all'):
>>> +                print('%-13s' %inode, end=3D'| ')
>>> +                print('%-7s' %otype, end=3D'| ')
>>> +                if (argument.type not in drop):
>>> +                    print('%-7s' %access, end=3D'| ')
>>> +                if (argument.type not in drop and argument.type =
!=3D'deleg'):
>>> +                    print('%-5s' %deny, end=3D'| ')
>>> +                if (argument.hostname =3D=3D True):
>>> +                    print('%-22s' %hostname, end=3D'| ')
>>> +                else:
>>> +                   print('%-22s' %client_ip, end=3D'| ')
>>> +                if (argument.clientinfo =3D=3D True) :
>>> +                    print('%-20s' %clientid, end=3D'| ')
>>> +                    print('4.%-3s' %minorversion, end=3D'| ')
>>> +                print(fname)
>>> +
>>> +def opener(path):
>>> +    try:
>>> +        with open(path, 'r') as nfsdata:
>>> +            data =3D yaml.load(nfsdata, Loader =3D yaml.BaseLoader)
>>> +            if data is not None:
>>> +                clientinfo =3D path.rsplit('/', 1)[0] + '/info'
>>> +                data.append(clientinfo)
>>> +                return data
>>> +
>>> +    except OSError as reason:
>>> +        print('%s' % reason)
>>> +
>>> +def print_cols(argument):
>>> +    title_inode =3D 'Inode number'
>>> +    title_otype =3D 'Type'
>>> +    title_access =3D 'Access'
>>> +    title_deny =3D 'Deny'
>>> +    title_fname =3D 'Filename'
>>> +    title_clientID =3D 'Client ID'
>>> +    title_hostname =3D 'Hostname'
>>> +    title_ip =3D 'ip address'
>>> +    title_nfsvers =3D 'vers'
>>> +
>>> +    drop =3D ['lock', 'layout']
>>> +    print(BBOLD, end=3D'')
>>> +    print('%-13s' %title_inode, end=3D'| ')
>>> +    print('%-7s' %title_otype, end=3D'| ')
>>> +    if (argument.type not in drop):
>>> +        print('%-7s' %title_access, end=3D'| ')
>>> +    if (argument.type not in drop and argument.type !=3D'deleg'):
>>> +        print('%-5s' %title_deny, end=3D'| ')
>>> +    if (argument.hostname =3D=3D True):
>>> +        print('%-22s' %title_hostname, end=3D'| ')
>>> +    else:
>>> +        print('%-22s' %title_ip, end=3D'| ')
>>> +    if (argument.clientinfo =3D=3D True):
>>> +        print('%-20s' %title_clientID, end=3D'| ')
>>> +        print('%-5s' %title_nfsvers, end=3D'| ')
>>> +    print(title_fname, end=3D'')
>>> +    print(ENDC)
>>> +
>>> +def nfsd4_show():
>>> +
>>> +    parser =3D argparse.ArgumentParser(description =3D 'Parse the =
nfsd states and clientinfo files.')
>>> +    parser.add_argument('-t', '--type', metavar =3D 'type', type =3D =
str, choices =3D ['open',
>>> +        'deleg', 'lock', 'layout', 'all'],
>>> +        default =3D 'all',
>>> +        help =3D 'Input the type that you want to be printed: open, =
lock, deleg, layout, all')
>>> +    parser.add_argument('--clientinfo', action =3D 'store_true',
>>> +        help =3D 'output clients information, --hostname is =
implied.')
>>> +    parser.add_argument('--hostname', action =3D 'store_true',
>>> +        help =3D 'print hostname of client instead of its ip =
address. Longer hostnames are truncated.')
>>> +    parser.add_argument('-q', '--quiet', action =3D 'store_true',
>>> +        help =3D 'don\'t print the header information')
>>> +
>>> +    args =3D parser.parse_args()
>>> +    paths =3D getpaths()
>>> +    p =3D mp.Pool(mp.cpu_count(), init_worker)
>>> +    try:
>>> +        result =3D p.map(opener, paths)
>>> +        p.close()
>>> +        p.join()
>>> +        if len(result) !=3D0 and not args.quiet and result[0] is =
not None:
>>> +            print_cols(args)
>>> +
>>> +        for i in result:
>>> +            if i is not None:
>>> +                printer(i, args)
>>> +
>>> +    except KeyboardInterrupt:
>>> +        print('Caught KeyboardInterrupt, terminating workers')
>>> +        p.terminate()
>>> +        p.join()
>>> +
>>> +if __name__ =3D=3D "__main__":
>>> +    nfsd4_show()

--
Chuck Lever



