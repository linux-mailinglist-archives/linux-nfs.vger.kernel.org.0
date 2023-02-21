Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 728A369E529
	for <lists+linux-nfs@lfdr.de>; Tue, 21 Feb 2023 17:52:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234835AbjBUQwY (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 21 Feb 2023 11:52:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233273AbjBUQwY (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 21 Feb 2023 11:52:24 -0500
Received: from mailrelay.rz.uni-wuerzburg.de (wrz3035.rz.uni-wuerzburg.de [132.187.3.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292A82B282
        for <linux-nfs@vger.kernel.org>; Tue, 21 Feb 2023 08:52:21 -0800 (PST)
Received: from virusscan-slb.rz.uni-wuerzburg.de (localhost [127.0.0.1])
        by mailrelay-slb.rz.uni-wuerzburg.de (Postfix) with ESMTP id 9D268EF7A;
        Tue, 21 Feb 2023 17:52:19 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by virusscan-slb.rz.uni-wuerzburg.de (Postfix) with ESMTP id 9BC6FEF6B;
        Tue, 21 Feb 2023 17:52:19 +0100 (CET)
X-Virus-Scanned: amavisd-new at uni-wuerzburg.de
Received: from mailmaster.uni-wuerzburg.de ([127.0.0.1])
        by localhost (vmail001.slb.uni-wuerzburg.de [127.0.0.1]) (amavisd-new, port 10225)
        with ESMTP id YEfLOuMvDVzo; Tue, 21 Feb 2023 17:52:19 +0100 (CET)
Received: from [132.187.207.113] (wma7113.mathematik.uni-wuerzburg.de [132.187.207.113])
        by mailmaster.uni-wuerzburg.de (Postfix) with ESMTPSA id 4CC62EF64;
        Tue, 21 Feb 2023 17:52:19 +0100 (CET)
Content-Type: multipart/mixed; boundary="------------PdJtHXEtARDuC3R3oSoYQes0"
Message-ID: <7c7de5f1-fb6a-e970-99a2-4880583d8f6d@mathematik.uni-wuerzburg.de>
Date:   Tue, 21 Feb 2023 17:52:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: Reoccurring 5 second delays during NFS calls
To:     Benjamin Coddington <bcodding@redhat.com>
Cc:     Jeff Layton <jlayton@kernel.org>, linux-nfs@vger.kernel.org,
        Andreas Seeg <andreas.seeg@mathematik.uni-wuerzburg.de>
References: <59682160-a246-395a-9486-9bbf11686740@mathematik.uni-wuerzburg.de>
 <8a02c86882bc47c1c1387dba8c7d756237cb3f3f.camel@kernel.org>
 <3b6c9b8e-2795-74e8-aefa-d4f1ac007c3c@mathematik.uni-wuerzburg.de>
 <785052D6-E39F-40D3-8BA3-72D3940EDD84@redhat.com>
Content-Language: en-US-large
From:   =?UTF-8?Q?Florian_M=c3=b6ller?= 
        <fmoeller@mathematik.uni-wuerzburg.de>
In-Reply-To: <785052D6-E39F-40D3-8BA3-72D3940EDD84@redhat.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org

This is a multi-part message in MIME format.
--------------PdJtHXEtARDuC3R3oSoYQes0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Benjamin,

here are the trace and a listing of the corresponding network packages. If the 
listing is not detailed enough, I can send you a full package dump tomorrow.

The command I used was

touch test.txt && sleep 2 && touch test.txt

test.txt did not exist previously. So you have an example of a touch without and 
with delay.

Best regards,
Florian

Am 21.02.23 um 15:13 schrieb Benjamin Coddington:
> On 21 Feb 2023, at 8:33, Florian Möller wrote:
> 
>> Hi all,
>>
>> unfortunately the patch did not help, neither using -o async nor using -o sync. We did some more tests (which is the reason for the delay of this reply):
>>
>> We used a qemu image housing both the NFS server and the client and did some kernel debugging.
>> OS: Ubuntu 22.04.1
>> Kernel: 5.15.78
>> Mount line: rw,relatime,vers=4.2,rsize=1048576,wsize=1048576,
>> 	namlen=255,hard,proto=tcp,timeo=600,retrans=2,
>> 	sec=krb5p,clientaddr=10.0.0.1,
>> 	local_lock=none,addr=10.0.0.1
>>
>> We touched a file and then touched the file again. This triggers the delay reliably.
>>
>> We set breakpoints on all functions starting with nfs4 and on "update_open_stateid". The attached file "1sttouch.log" contains a gdb log of the first touch.
>> "2ndtouch.log" shows the gdb output of the second touch. The delay occurs in line 116 in update_open_stateid.
>>
>> We then deleted all breakpoints and set a sole breakpoint on update_open_stateid. We touched the file again and used only the "next" command of gdb. The gdb output is in "2ndtouch-next.log", the delay occurs in line 8.
>>
>> Please let us know if you need more information or if you want us to perform further tests.
>>
>> Best regards,
>> Florian Möller
> 
> Hi Florian,
> 
> The 5 second value and location of the delay is making me suspect something
> is wrong with the open stateid sequence processing.
> 
> The client introduces 5-second delays in order to correctly order stateid
> updates from the server.  Usually this happens because there are multiple
> processes sending OPEN/CLOSE calls and the server processess them out of
> order, or the client receives the responses out of order.
> 
> It would be helpful to have a network capture of the problem, along with the
> matching output from these tracepoints on the client:
> 
> nfs4:nfs4_open_stateid_update
> nfs4:nfs4_open_stateid_update_wait
> nfs4:nfs4_close_stateid_update_wait
> sunrpc:xs_stream_read_request
> sunrpc:rpc_request
> sunrpc:rpc_task_end
> 
> And these tracepoints on the server:
> 
> nfsd:nfsd_preprocess
> sunrpc:svc_process
> 
> I'm interested in seeing how the client is processing the sequence numbers
> of the open stateid, or if perhaps there's a delegation in play.
> 
> LMK if you need help with the tracepoints -- you can simply append those
> lines into /sys/kernel/debug/tracing/set_event, then reproduce the problem.
> The output of those tracepoints will be in /sys/kernel/debug/tracing/trace.
> 
> Ben

-- 
Dr. Florian Möller
Universität Würzburg
Institut für Mathematik
Emil-Fischer-Straße 30
97074 Würzburg, Germany
Tel. +49 931 3185596

--------------PdJtHXEtARDuC3R3oSoYQes0
Content-Type: text/plain; charset=UTF-8; name="nfs-network.txt"
Content-Disposition: attachment; filename="nfs-network.txt"
Content-Transfer-Encoding: base64

ICAgNTcgMzAuNzIwNDI4ODI4IDEwLjEyNi4wLjEwOSDihpIgMTAuMTI2LjAuMTA5IE5GUyAy
NTIgW1RDUCBQcmV2aW91cyBzZWdtZW50IG5vdCBjYXB0dXJlZF0gVjQgQ2FsbCBTRVFVRU5D
RQogICA1OCAzMC43MjA1OTIzOTAgMTAuMTI2LjAuMTA5IOKGkiAxMC4xMjYuMC4xMDkgTkZT
IDIyMCBbVENQIEFDS2VkIHVuc2VlbiBzZWdtZW50XSBWNCBSZXBseSAoQ2FsbCBJbiA1Nykg
U0VRVUVOQ0UKICAgNTkgMzAuNzIwNjExNjU1IDEwLjEyNi4wLjEwOSDihpIgMTAuMTI2LjAu
MTA5IFRDUCA2OCA5Nzgg4oaSIDIwNDkgW0FDS10gU2VxPTE4NiBBY2s9MTUzIFdpbj01MTEg
TGVuPTAgVFN2YWw9MTczNzUzMTM1IFRTZWNyPTE3Mzc1MzEzNQogICA2MSA1Mi40NzM0OTAy
NzIgMTAuMTI2LjAuMTA5IOKGkiAxMC4xMjYuMC4xMDkgTkZTIDMyMCBWNCBDYWxsCiAgIDYy
IDUyLjQ3MzYwNjcwMCAxMC4xMjYuMC4xMDkg4oaSIDEwLjEyNi4wLjEwOSBORlMgNDIwIFY0
IFJlcGx5IChDYWxsIEluIDYxKQogICA2MyA1Mi40NzM2MTQ5MjMgMTAuMTI2LjAuMTA5IOKG
kiAxMC4xMjYuMC4xMDkgVENQIDY4IDk3OCDihpIgMjA0OSBbQUNLXSBTZXE9NDM4IEFjaz01
MDUgV2luPTUxMCBMZW49MCBUU3ZhbD0xNzM3NzQ4ODggVFNlY3I9MTczNzc0ODg4CiAgIDY0
IDUyLjQ3Nzg0OTI1MCAxMC4xMjYuMC4xMDkg4oaSIDEwLjEyNi4wLjEwOSBORlMgNDMyIFY0
IENhbGwKICAgNjUgNTIuNDc3OTgxNTYyIDEwLjEyNi4wLjEwOSDihpIgMTAuMTI2LjAuMTA5
IE5GUyA1NDAgVjQgUmVwbHkgKENhbGwgSW4gNjQpCiAgIDY2IDUyLjQ4MTEyMzIzMSAxMC4x
MjYuMC4xMDkg4oaSIDEwLjEyNi4wLjEwOSBORlMgMzY0IFY0IENhbGwKICAgNjcgNTIuNDgx
MjU1MDYwIDEwLjEyNi4wLjEwOSDihpIgMTAuMTI2LjAuMTA5IE5GUyA0NTIgVjQgUmVwbHkg
KENhbGwgSW4gNjYpCiAgIDY4IDUyLjQ4MTM4MzE3MyAxMC4xMjYuMC4xMDkg4oaSIDEwLjEy
Ni4wLjEwOSBORlMgMzE2IFY0IENhbGwgQ0xPU0UgU3RhdGVJRDogMHhhYjQxCiAgIDY5IDUy
LjQ4MTQyNTg3NSAxMC4xMjYuMC4xMDkg4oaSIDEwLjEyNi4wLjEwOSBORlMgMjI4IFY0IFJl
cGx5IChDYWxsIEluIDY4KSBTRVFVRU5DRSB8IFBVVEZIIFN0YXR1czogTkZTNEVSUl9TVEFM
RQogICA3MCA1Mi40ODE3NzQyNzQgMTAuMTI2LjAuMTA5IOKGkiAxMC4xMjYuMC4xMDkgTkZT
IDMyMCBWNCBDYWxsCiAgIDcxIDUyLjQ4Mjg1MTY4OCAxMC4xMjYuMC4xMDkg4oaSIDEwLjEy
Ni4wLjEwOSBORlMgNDIwIFY0IFJlcGx5IChDYWxsIEluIDcwKQogICA3MiA1Mi41MjM5OTc1
NjIgMTAuMTI2LjAuMTA5IOKGkiAxMC4xMjYuMC4xMDkgVENQIDY4IDk3OCDihpIgMjA0OSBb
QUNLXSBTZXE9MTU5OCBBY2s9MTg3MyBXaW49NTEyIExlbj0wIFRTdmFsPTE3Mzc3NDkzOCBU
U2Vjcj0xNzM3NzQ4OTcKICAgNzMgNTQuNDg5MDYwMjQ0IDEwLjEyNi4wLjEwOSDihpIgMTAu
MTI2LjAuMTA5IE5GUyAzODggVjQgQ2FsbAogICA3NCA1NC40ODkzNDA3NDQgMTAuMTI2LjAu
MTA5IOKGkiAxMC4xMjYuMC4xMDkgTkZTIDUwNCBWNCBSZXBseSAoQ2FsbCBJbiA3MykKICAg
NzUgNTQuNDg5MzY0MjcwIDEwLjEyNi4wLjEwOSDihpIgMTAuMTI2LjAuMTA5IFRDUCA2OCA5
Nzgg4oaSIDIwNDkgW0FDS10gU2VxPTE5MTggQWNrPTIzMDkgV2luPTUwOSBMZW49MCBUU3Zh
bD0xNzM3NzY5MDQgVFNlY3I9MTczNzc2OTAzCiAgIDc2IDU5LjY0ODQzNzQ4NSAxMC4xMjYu
MC4xMDkg4oaSIDEwLjEyNi4wLjEwOSBORlMgMzY0IFY0IENhbGwKICAgNzcgNTkuNjQ4OTY2
NzA5IDEwLjEyNi4wLjEwOSDihpIgMTAuMTI2LjAuMTA5IE5GUyA0NTIgVjQgUmVwbHkgKENh
bGwgSW4gNzYpCiAgIDc4IDU5LjY0ODk5MTgxMiAxMC4xMjYuMC4xMDkg4oaSIDEwLjEyNi4w
LjEwOSBUQ1AgNjggOTc4IOKGkiAyMDQ5IFtBQ0tdIFNlcT0yMjE0IEFjaz0yNjkzIFdpbj01
MDkgTGVuPTAgVFN2YWw9MTczNzgyMDYzIFRTZWNyPTE3Mzc4MjA2MwogICA3OSA1OS42NTEw
MzIwNjEgMTAuMTI2LjAuMTA5IOKGkiAxMC4xMjYuMC4xMDkgTkZTIDMxNiBWNCBDYWxsIENM
T1NFIFN0YXRlSUQ6IDB4YTViNgogICA4MCA1OS42NTE0Mjk1ODMgMTAuMTI2LjAuMTA5IOKG
kiAxMC4xMjYuMC4xMDkgTkZTIDIyOCBWNCBSZXBseSAoQ2FsbCBJbiA3OSkgU0VRVUVOQ0Ug
fCBQVVRGSCBTdGF0dXM6IE5GUzRFUlJfU1RBTEUKICAgODEgNTkuNjkxODk0NDI4IDEwLjEy
Ni4wLjEwOSDihpIgMTAuMTI2LjAuMTA5IFRDUCA2OCA5Nzgg4oaSIDIwNDkgW0FDS10gU2Vx
PTI0NjIgQWNrPTI4NTMgV2luPTUxMiBMZW49MCBUU3ZhbD0xNzM3ODIxMDYgVFNlY3I9MTcz
NzgyMDY2Cg==
--------------PdJtHXEtARDuC3R3oSoYQes0
Content-Type: text/plain; charset=UTF-8; name="nfs-trace.txt"
Content-Disposition: attachment; filename="nfs-trace.txt"
Content-Transfer-Encoding: base64

ICAgICAgICAgICB0b3VjaC0yNDc2ICAgIFswMDBdIC4uLi4uICAxODQxLjUxMjQ4NDogcnBj
X3JlcXVlc3Q6IHRhc2s6MTI5QDQgbmZzdjQgR0VUQVRUUiAoc3luYykKICAgICAgICAgICAg
bmZzZC04OTMgICAgIFswMDBdIC4uLi4uICAxODQxLjUxNTAyMjogc3ZjX3Byb2Nlc3M6IGFk
ZHI9MTAuMTI2LjAuMTA5Ojk3OCB4aWQ9MHhmZmQyNGVlOSBzZXJ2aWNlPW5mc2QgdmVycz00
IHByb2M9Q09NUE9VTkQKICAgIGt3b3JrZXIvdTM6MC0xMTIgICAgIFswMDBdIC4uLi4uICAx
ODQxLjUxNTEwODogeHNfc3RyZWFtX3JlYWRfcmVxdWVzdDogcGVlcj1bMTAuMTI2LjAuMTA5
XToyMDQ5IHhpZD0weGZmZDI0ZWU5IGNvcGllZD0zNDggcmVjbGVuPTM0OCBvZmZzZXQ9MzQ4
CiAgICAgICAgICAgdG91Y2gtMjQ3NiAgICBbMDAwXSAuLi4uLiAgMTg0MS41MTkxOTE6IHJw
Y190YXNrX2VuZDogdGFzazoxMjlANCBmbGFncz1NT1ZFQUJMRXxEWU5BTUlDfFNFTlR8Tk9S
VE98Q1JFRF9OT1JFRiBydW5zdGF0ZT1SVU5OSU5HfEFDVElWRSBzdGF0dXM9MCBhY3Rpb249
cnBjX2V4aXRfdGFzayBbc3VucnBjXQogICAga3dvcmtlci91MjowLTE5MDYgICAgWzAwMF0g
Li4uLi4gIDE4NDEuNTE5Mjg5OiBycGNfcmVxdWVzdDogdGFzazoxMzBANCBuZnN2NCBPUEVO
IChhc3luYykKICAgICAgICAgICAgbmZzZC04OTMgICAgIFswMDBdIC4uLi4uICAxODQxLjUx
OTM4MTogc3ZjX3Byb2Nlc3M6IGFkZHI9MTAuMTI2LjAuMTA5Ojk3OCB4aWQ9MHgwMGQzNGVl
OSBzZXJ2aWNlPW5mc2QgdmVycz00IHByb2M9Q09NUE9VTkQKICAgIGt3b3JrZXIvdTM6MC0x
MTIgICAgIFswMDBdIC4uLi4uICAxODQxLjUxOTQ4MjogeHNfc3RyZWFtX3JlYWRfcmVxdWVz
dDogcGVlcj1bMTAuMTI2LjAuMTA5XToyMDQ5IHhpZD0weDAwZDM0ZWU5IGNvcGllZD00Njgg
cmVjbGVuPTQ2OCBvZmZzZXQ9NDY4CiAgICBrd29ya2VyL3UyOjAtMTkwNiAgICBbMDAwXSAu
Li4uLiAgMTg0MS41MjA2ODQ6IHJwY190YXNrX2VuZDogdGFzazoxMzBANCBmbGFncz1BU1lO
Q3xNT1ZFQUJMRXxEWU5BTUlDfFNFTlR8Tk9SVE98Q1JFRF9OT1JFRiBydW5zdGF0ZT1SVU5O
SU5HfEFDVElWRSBzdGF0dXM9MCBhY3Rpb249cnBjX2V4aXRfdGFzayBbc3VucnBjXQogICAg
ICAgICAgIHRvdWNoLTI0NzYgICAgWzAwMF0gLi4uLi4gIDE4NDEuNTIyNTUxOiBuZnM0X29w
ZW5fc3RhdGVpZF91cGRhdGU6IGVycm9yPTAgKE9LKSBmaWxlaWQ9MDA6MmU6MTA0ODg4NyBm
aGFuZGxlPTB4NWE4MzViZDEgc3RhdGVpZD0xOjB4OGZlNWJkZmQKICAgICAgICAgICB0b3Vj
aC0yNDc2ICAgIFswMDBdIC4uLi4uICAxODQxLjUyMjU3MTogcnBjX3JlcXVlc3Q6IHRhc2s6
MTMxQDQgbmZzdjQgU0VUQVRUUiAoc3luYykKICAgICAgICAgICAgbmZzZC04OTMgICAgIFsw
MDBdIC4uLi4uICAxODQxLjUyMjY5NTogc3ZjX3Byb2Nlc3M6IGFkZHI9MTAuMTI2LjAuMTA5
Ojk3OCB4aWQ9MHgwMWQzNGVlOSBzZXJ2aWNlPW5mc2QgdmVycz00IHByb2M9Q09NUE9VTkQK
ICAgIGt3b3JrZXIvdTM6MC0xMTIgICAgIFswMDBdIC4uLi4uICAxODQxLjUyMjc1MDogeHNf
c3RyZWFtX3JlYWRfcmVxdWVzdDogcGVlcj1bMTAuMTI2LjAuMTA5XToyMDQ5IHhpZD0weDAx
ZDM0ZWU5IGNvcGllZD0zODAgcmVjbGVuPTM4MCBvZmZzZXQ9MzgwCiAgICAgICAgICAgdG91
Y2gtMjQ3NiAgICBbMDAwXSAuLi4uLiAgMTg0MS41MjI4MjU6IHJwY190YXNrX2VuZDogdGFz
azoxMzFANCBmbGFncz1NT1ZFQUJMRXxEWU5BTUlDfFNFTlR8Tk9SVE98Q1JFRF9OT1JFRiBy
dW5zdGF0ZT1SVU5OSU5HfEFDVElWRSBzdGF0dXM9MCBhY3Rpb249cnBjX2V4aXRfdGFzayBb
c3VucnBjXQogICAga3dvcmtlci91MjowLTE5MDYgICAgWzAwMF0gLi4uLi4gIDE4NDEuNTIy
ODQyOiBycGNfcmVxdWVzdDogdGFzazoxMzJAMiBuZnN2NCBDTE9TRSAoYXN5bmMpCiAgICAg
ICAgICAgIG5mc2QtODkzICAgICBbMDAwXSAuLi4uLiAgMTg0MS41MjI4OTE6IHN2Y19wcm9j
ZXNzOiBhZGRyPTEwLjEyNi4wLjEwOTo5NzggeGlkPTB4MDJkMzRlZTkgc2VydmljZT1uZnNk
IHZlcnM9NCBwcm9jPUNPTVBPVU5ECiAgICBrd29ya2VyL3UzOjAtMTEyICAgICBbMDAwXSAu
Li4uLiAgMTg0MS41MjI5MTY6IHhzX3N0cmVhbV9yZWFkX3JlcXVlc3Q6IHBlZXI9WzEwLjEy
Ni4wLjEwOV06MjA0OSB4aWQ9MHgwMmQzNGVlOSBjb3BpZWQ9MTU2IHJlY2xlbj0xNTYgb2Zm
c2V0PTE1NgogICAga3dvcmtlci91MjowLTE5MDYgICAgWzAwMF0gLi4uLi4gIDE4NDEuNTIy
OTI5OiBycGNfdGFza19lbmQ6IHRhc2s6MTMyQDIgZmxhZ3M9QVNZTkN8TU9WRUFCTEV8RFlO
QU1JQ3xTT0ZUfFNFTlR8Tk9SVE98Q1JFRF9OT1JFRiBydW5zdGF0ZT1SVU5OSU5HfEFDVElW
RSBzdGF0dXM9LTExNiBhY3Rpb249cnBjX2V4aXRfdGFzayBbc3VucnBjXQogICAgICAgICAg
ICBiYXNoLTIyMzAgICAgWzAwMF0gLi4uLi4gIDE4NDEuNTIzMjE5OiBycGNfcmVxdWVzdDog
dGFzazoxMzNANCBuZnN2NCBHRVRBVFRSIChzeW5jKQogICAgICAgICAgICBuZnNkLTg5MyAg
ICAgWzAwMF0gLi4uLi4gIDE4NDEuNTI0MzAzOiBzdmNfcHJvY2VzczogYWRkcj0xMC4xMjYu
MC4xMDk6OTc4IHhpZD0weDAzZDM0ZWU5IHNlcnZpY2U9bmZzZCB2ZXJzPTQgcHJvYz1DT01Q
T1VORAogICAga3dvcmtlci91MzowLTExMiAgICAgWzAwMF0gLi4uLi4gIDE4NDEuNTI0MzQ3
OiB4c19zdHJlYW1fcmVhZF9yZXF1ZXN0OiBwZWVyPVsxMC4xMjYuMC4xMDldOjIwNDkgeGlk
PTB4MDNkMzRlZTkgY29waWVkPTM0OCByZWNsZW49MzQ4IG9mZnNldD0zNDgKICAgICAgICAg
ICAgYmFzaC0yMjMwICAgIFswMDBdIC4uLi4uICAxODQxLjUyNDQyNzogcnBjX3Rhc2tfZW5k
OiB0YXNrOjEzM0A0IGZsYWdzPU1PVkVBQkxFfERZTkFNSUN8U0VOVHxOT1JUT3xDUkVEX05P
UkVGIHJ1bnN0YXRlPVJVTk5JTkd8QUNUSVZFIHN0YXR1cz0wIGFjdGlvbj1ycGNfZXhpdF90
YXNrIFtzdW5ycGNdCiAgICBrd29ya2VyL3UyOjEtMjQ4MCAgICBbMDAwXSAuLi4uLiAgMTg0
My41MzAxNzM6IHJwY19yZXF1ZXN0OiB0YXNrOjEzNEA0IG5mc3Y0IE9QRU5fTk9BVFRSIChh
c3luYykKICAgICAgICAgICAgbmZzZC04OTMgICAgIFswMDBdIC4uLi4uICAxODQzLjUzMDY3
MDogc3ZjX3Byb2Nlc3M6IGFkZHI9MTAuMTI2LjAuMTA5Ojk3OCB4aWQ9MHgwNGQzNGVlOSBz
ZXJ2aWNlPW5mc2QgdmVycz00IHByb2M9Q09NUE9VTkQKICAgIGt3b3JrZXIvdTM6MC0xMTIg
ICAgIFswMDBdIC4uLi4uICAxODQzLjUzMDg3NDogeHNfc3RyZWFtX3JlYWRfcmVxdWVzdDog
cGVlcj1bMTAuMTI2LjAuMTA5XToyMDQ5IHhpZD0weDA0ZDM0ZWU5IGNvcGllZD00MzIgcmVj
bGVuPTQzMiBvZmZzZXQ9NDMyCiAgICBrd29ya2VyL3UyOjEtMjQ4MCAgICBbMDAwXSAuLi4u
LiAgMTg0My41MzExNDI6IHJwY190YXNrX2VuZDogdGFzazoxMzRANCBmbGFncz1BU1lOQ3xN
T1ZFQUJMRXxEWU5BTUlDfFNFTlR8Tk9SVE98Q1JFRF9OT1JFRiBydW5zdGF0ZT1SVU5OSU5H
fEFDVElWRSBzdGF0dXM9MCBhY3Rpb249cnBjX2V4aXRfdGFzayBbc3VucnBjXQogICAgICAg
ICAgIHRvdWNoLTI0ODIgICAgWzAwMF0gLi4uLi4gIDE4NDMuNTMxMzk1OiBuZnM0X29wZW5f
c3RhdGVpZF91cGRhdGVfd2FpdDogZXJyb3I9MCAoT0spIGZpbGVpZD0wMDoyZToxMDQ4ODg3
IGZoYW5kbGU9MHg1YTgzNWJkMSBzdGF0ZWlkPTI6MHg4ZmU1YmRmZAogICAgICAgICAgIHRv
dWNoLTI0ODIgICAgWzAwMF0gLi4uLi4gIDE4NDguNjg5NjM0OiBuZnM0X29wZW5fc3RhdGVp
ZF91cGRhdGU6IGVycm9yPS0xMSAoRUFHQUlOKSBmaWxlaWQ9MDA6MmU6MTA0ODg4NyBmaGFu
ZGxlPTB4NWE4MzViZDEgc3RhdGVpZD0yOjB4OGZlNWJkZmQKICAgICAgICAgICB0b3VjaC0y
NDgyICAgIFswMDBdIC4uLi4uICAxODQ4LjY4OTcyODogcnBjX3JlcXVlc3Q6IHRhc2s6MTM1
QDQgbmZzdjQgU0VUQVRUUiAoc3luYykKICAgICAgICAgICAgbmZzZC04OTMgICAgIFswMDBd
IC4uLi4uICAxODQ4LjY5MDI2Nzogc3ZjX3Byb2Nlc3M6IGFkZHI9MTAuMTI2LjAuMTA5Ojk3
OCB4aWQ9MHgwNWQzNGVlOSBzZXJ2aWNlPW5mc2QgdmVycz00IHByb2M9Q09NUE9VTkQKICAg
IGt3b3JrZXIvdTM6MC0xMTIgICAgIFswMDBdIC4uLi4uICAxODQ4LjY5MDQ5NDogeHNfc3Ry
ZWFtX3JlYWRfcmVxdWVzdDogcGVlcj1bMTAuMTI2LjAuMTA5XToyMDQ5IHhpZD0weDA1ZDM0
ZWU5IGNvcGllZD0zODAgcmVjbGVuPTM4MCBvZmZzZXQ9MzgwCiAgICAgICAgICAgdG91Y2gt
MjQ4MiAgICBbMDAwXSAuLi4uLiAgMTg0OC42OTA4MDY6IHJwY190YXNrX2VuZDogdGFzazox
MzVANCBmbGFncz1NT1ZFQUJMRXxEWU5BTUlDfFNFTlR8Tk9SVE98Q1JFRF9OT1JFRiBydW5z
dGF0ZT1SVU5OSU5HfEFDVElWRSBzdGF0dXM9MCBhY3Rpb249cnBjX2V4aXRfdGFzayBbc3Vu
cnBjXQogICAga3dvcmtlci91MjoxLTI0ODAgICAgWzAwMF0gLi4uLi4gIDE4NDguNjkxNjI3
OiBycGNfcmVxdWVzdDogdGFzazoxMzZAMiBuZnN2NCBDTE9TRSAoYXN5bmMpCiAgICAgICAg
ICAgIG5mc2QtODkzICAgICBbMDAwXSAuLi4uLiAgMTg0OC42OTI1ODY6IHN2Y19wcm9jZXNz
OiBhZGRyPTEwLjEyNi4wLjEwOTo5NzggeGlkPTB4MDZkMzRlZTkgc2VydmljZT1uZnNkIHZl
cnM9NCBwcm9jPUNPTVBPVU5ECiAgICBrd29ya2VyL3UzOjAtMTEyICAgICBbMDAwXSAuLi4u
LiAgMTg0OC42OTI5MzE6IHhzX3N0cmVhbV9yZWFkX3JlcXVlc3Q6IHBlZXI9WzEwLjEyNi4w
LjEwOV06MjA0OSB4aWQ9MHgwNmQzNGVlOSBjb3BpZWQ9MTU2IHJlY2xlbj0xNTYgb2Zmc2V0
PTE1NgogICAga3dvcmtlci91MjoxLTI0ODAgICAgWzAwMF0gLi4uLi4gIDE4NDguNjkzMTU3
OiBycGNfdGFza19lbmQ6IHRhc2s6MTM2QDIgZmxhZ3M9QVNZTkN8TU9WRUFCTEV8RFlOQU1J
Q3xTT0ZUfFNFTlR8Tk9SVE98Q1JFRF9OT1JFRiBydW5zdGF0ZT1SVU5OSU5HfEFDVElWRSBz
dGF0dXM9LTExNiBhY3Rpb249cnBjX2V4aXRfdGFzayBbc3VucnBjXQo=

--------------PdJtHXEtARDuC3R3oSoYQes0--
