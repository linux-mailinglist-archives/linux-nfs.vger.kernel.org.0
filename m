Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C410949B7D5
	for <lists+linux-nfs@lfdr.de>; Tue, 25 Jan 2022 16:43:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1582065AbiAYPlM (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Tue, 25 Jan 2022 10:41:12 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:28922 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1581729AbiAYPjF (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Tue, 25 Jan 2022 10:39:05 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20PErim9026537;
        Tue, 25 Jan 2022 15:38:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=S0mXcJawYRVXLQIzpwRJ2SboFhxdHjCAjQGgYWN14lA=;
 b=U0XdmHXbwbpUOtfsCeshVvevl3/pcfvlLm3Z2uicM0A3uvnpAk/wYgDqdpY2z8/aLEEZ
 kvZD3pFduzych13GHO8LYQmkR+MHjtnVeV1SsgDGrLz/6G9irEvVj6BWwlOVveU33TX2
 zRXHokFI1zQtPCq9mCiVn3gc6wmZcj4K8S0v3VRUkDNecZ/jNSDkg4Tm72oTpo/cGHa9
 RmAFN3NLIjHkXZ86ILSBFlheBe7aZ1llyq5NK50bAEzFG7/z73wbuizpfKTIkFCpybkP
 7urQnBxdB6Tx3h+37VUgr7i4QeK4XL7HDfPbJfKzt6gjFlBzYQMh2P99cI6xm8GA82PZ zQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsvmjbvyd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 15:38:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20PFZJJo192995;
        Tue, 25 Jan 2022 15:38:25 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by aserp3030.oracle.com with ESMTP id 3dr7yg3cnj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jan 2022 15:38:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HLWmqhkvKoeVupP/qKgcOCTezNZtDoDuC9YfS1GMpermVsAiVXRoTgkVpamX2BxnAI9lxlvOrTbYAKt8xWdgHcINvcgCY/qS75IQhE/K6peHkqYm4e/ZEsqYdvmzQnrYtXKdUsO3pmuaorEUaNraCXY7C6WtXEHvkPfDUKlZmc5+fW4u6+oG5XIhH2RLllwWCMIfUMTGiNzRS9Nm8iU3dtRlJ+wot9ZMAthhUhYMVt6eCpEZh3kQHhRCUUH0le+eJ++tVol3a6GJ4F+PJ+bsS2hdyIyZJMNleQfwZgbjKFI/eyEX2Zg41viUe13xQ3SS4xkpFtFI3Gax9wV3LQFZjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S0mXcJawYRVXLQIzpwRJ2SboFhxdHjCAjQGgYWN14lA=;
 b=P4qskQHnB/0S4ANOykTzQSnUB3gZiQvfM+kNkeCOvftHRk2Nn82/TA6HBy/WLt7zwrTxahzDaUNjxfVyWtcmH5BgncL9X4hZ4Bztwn6uQYNA38VXNivYuvR5oakZh71PjtlP96jiQmQ/3EioO9Pm07ut5yormduQtTXpGSW+h0hFxDS4vUqhGiVw178khcTiqMn7dQa3Vf5Gw/de/IblKFirizeQ0WaM+0c5LmS1vAWSM6zZuUEzWzF8L6PLLkeNbuHzmOOzZzz2awM9ErC/5wZpzpQIRI9iWFQAlQfB06P7Yn3JAe+tZAY/W5obOAEb5EcWPwA45WG0sk/cPegVEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S0mXcJawYRVXLQIzpwRJ2SboFhxdHjCAjQGgYWN14lA=;
 b=Z8y+LwOHfFNXszLwiKOyT6V81LACeLHXi1ydWH7QDjyLxuAheYCchn112uyNlLNc/G+cFOmJPeO6crZnJyxzDlTniTqkZ683KrBS0XO6vr6/CvQlP56AB/zfbaG3Fl7kiKa5FRMcQYR9EfdgWWL9+56E6xJ4v6m9xW4n9r35+5U=
Received: from CH0PR10MB4858.namprd10.prod.outlook.com (2603:10b6:610:cb::17)
 by CH0PR10MB5065.namprd10.prod.outlook.com (2603:10b6:610:c5::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.8; Tue, 25 Jan
 2022 15:38:22 +0000
Received: from CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7]) by CH0PR10MB4858.namprd10.prod.outlook.com
 ([fe80::241e:15fa:e7d8:dea7%9]) with mapi id 15.20.4909.017; Tue, 25 Jan 2022
 15:38:22 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Steven Rostedt <rostedt@goodmis.org>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Anna Schumaker <Anna.Schumaker@Netapp.com>,
        Trond Myklebust <trondmy@gmail.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: linux-next: runtime warning in next-20220125
Thread-Topic: linux-next: runtime warning in next-20220125
Thread-Index: AQHYEaktcg7+1kysjUiIdD4hmV/HjKxzM5EAgACiBACAAAmigIAAAKCA
Date:   Tue, 25 Jan 2022 15:38:22 +0000
Message-ID: <E23F5174-F706-40FC-9072-143B04905208@oracle.com>
References: <20220125160505.068dbb52@canb.auug.org.au>
 <20220125162146.13872bdb@canb.auug.org.au>
 <20220125100138.0d19c8ca@gandalf.local.home>
 <20220125103607.2dc307e2@gandalf.local.home>
In-Reply-To: <20220125103607.2dc307e2@gandalf.local.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 58767cf2-da50-4ff3-804d-08d9e018b868
x-ms-traffictypediagnostic: CH0PR10MB5065:EE_
x-microsoft-antispam-prvs: <CH0PR10MB50654C060B448A6D5BD89592935F9@CH0PR10MB5065.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:813;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 1H3ZhJzgVi/XhhWhrjtt+gUx1ACmrGz822Pszc1ph6VJTnXXY1gPehrYjaIK3bN5afF6V9Xaw4fI46uGtuGb/6y1JnWje+jNDGEuvqI+DjNmnOtvLR6j7P9rpiv85zlKFuwtI36uD3MxRPHh78JxaYTZBV8Ta0U/kurulnVATnqm5Q0h18hW2GgzqV7QAZmXWWKm9u4aPyu8aWt3RFte95Pq+wqzSnVwuo9AQFb04W0UYgc6AzN1cKBCI6Ys9bOYDcgIfcrN2EpC1AudCAJ08AvIkDA4OpJJ6ciSif5J+27n6cOs/nNdk8iXr1YoXAPT6bWen2bcrYONvAd57vY8OZTe7wrJ6eZHfbL64stwdKhB3pfqheNkwAmk/LFXxQU7QD94AAHNZ5mCDNOFAkvou+3ClA6JJC6LXrjaCFzGeQoQxeehP1NtP1l4WitsMI75Z73lhzwF/Cud8pnTxGDCX69uwtcyU8ZKoNqLyKWrl3VMVhQke/+iC/z/U8VJXH71eftNt/9YMC9OJWquDw2jXbIxOK389RdHwn9bjJadeR8pcsoQeO+WILDdA/SIbTMamlUBV7lFli/Dfsd1+UzGZwVD+4iRFykhfgyh9lBCW15AVoYSuhiGkeclm+0Rxj/IQMvEOQRYaoS86QTP589t+1H0cOL54JAHvJTgZKvsOMzlbZGbVUg7F37wwEhz7wdCJsPTu2MtS1LhH/k4cfAooSVIbrf08Uu7Iopw7N60k1yzW/kaAK78eSsE85dphnGk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB4858.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(2616005)(4326008)(5660300002)(6916009)(186003)(54906003)(86362001)(33656002)(508600001)(53546011)(6506007)(45080400002)(316002)(26005)(76116006)(6512007)(66946007)(71200400001)(36756003)(66446008)(64756008)(38070700005)(66476007)(66556008)(83380400001)(8676002)(6486002)(8936002)(122000001)(38100700002)(2906002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?FAwDM8rRMQ+sVqMqJdIaMyt7c8nve2nannd1si/Yfp4EWq/JM3aFo4XXN1Vn?=
 =?us-ascii?Q?ulNlFfmpUZUWD3RYdDGEhecc8ujw/VESDzAtEEzYD1J8DRfYhBaBP7QAErri?=
 =?us-ascii?Q?WzVpT8KGUSrTGu51ldN3g6kkQt3RYy8mMwOi/fOvrBIJ0Eao4z8s7SEQsvnR?=
 =?us-ascii?Q?xW8T++paz4DaHk9RNebtH27U7EWAjQSImoagVf/7Qb4Ev8QbTvVbCmP0hMkk?=
 =?us-ascii?Q?TrNylLmoedrCsW6MREvj04Q9VstGF7TYMFz8AGEyTrQ1bfmrOdwqQIsy4x/F?=
 =?us-ascii?Q?hYwCm5aeCGwTqBTIUe47EfOgKWu+tY69lLB5DNs+7anqr12XvPwvSFVKBF1A?=
 =?us-ascii?Q?y997YB6oLP7TEEmPCnMwaW2N6FzPTX3Cfb61szvZz/FMXJDFJEg4LJ2UQTB2?=
 =?us-ascii?Q?m7Ej32OxkOLM1z4soCbZyEBvjFOskmWng9Ag6t8DpaCrna5rYtB+g/8BMH0O?=
 =?us-ascii?Q?zCTvUx7euI6OVAZDd0QVFBfHvbnhFLgJKlw1H5GSocGNE7clkrez0rrA37QY?=
 =?us-ascii?Q?B3taSpqnczosKzoAlFhdIFZKomjiyQhGc+3fWdE7a4T/TUeuBdYNzlndd2fE?=
 =?us-ascii?Q?CFOl6/ConyZIbTitMlMFvRSCykIDgIZ7A9SdLuFdqF+s4V3HiRhCXAx26RIc?=
 =?us-ascii?Q?Q8+LgMN010S+3Ik3nL4eu6GdOyomcWQeQkRm9/IbE0v2U5iIcVLsxKSTP2ns?=
 =?us-ascii?Q?QglgHxZdWvhFlaba0ScdusC3vvZbF3oJ6Ubx+joj6Gim+96+ZUzxHOuPpsNJ?=
 =?us-ascii?Q?l5uLPZsfNi0D3d1Br/7EUjOCjy3/y17nmLhyyRNnryB3qJNI9sk1VsSTyZSb?=
 =?us-ascii?Q?L+TDm2/bfbxG7MsfEYU6KsiSCUURhAJ2cy8MZ2U0ruSsryBSfswJmGw3RREI?=
 =?us-ascii?Q?YNoWdDV66lnD3RYkrc92eV/qRCzhNocd7xzObgtGWKWZIazsaxQmPlv07vSi?=
 =?us-ascii?Q?EhTtjfSy549nlWH5FZOfJ5MurdCCbdi48BwMzUDGlUUtIQ8tba2V7/VuvIdf?=
 =?us-ascii?Q?lZul/JskLqBWAwAGRLbXm++PMK1oP160V8fhJEJul9jvFXNFHLBECI+ZIbQo?=
 =?us-ascii?Q?my+kHi4EExrio5IaxqKGYVvjAlHe1YLOrkypZlAQIoRF9i7/Io3HPLFLY4Qi?=
 =?us-ascii?Q?pzCrh6cqGQRdSZCZiA347Q2cRLSe+bXFE7T2ALN5T7lKtfQK7gIG7RjKxNy0?=
 =?us-ascii?Q?ZooiroEgKCnWXDZ7uoo+DOmK+nFQyJV23H8BwXy3i34G320g2on6OZh/TjMN?=
 =?us-ascii?Q?UQNBTgkOwg5X6fvmq8w9K6EeBJgEO0yiQRVqcBbxqE7KHq0lCLIdCY5yVkU5?=
 =?us-ascii?Q?tX6pqzbean3Hzq3Oq5+0MUfI+7wKcr894VkQpdYZxfcWlc5Qaq/USpCcmVRk?=
 =?us-ascii?Q?R5E6FnJ9cOLud1XZ58Z6hViK27yJPKA1AsWXG1OjYGsD4F4Y02yZioqL7oi1?=
 =?us-ascii?Q?Fm3VZJesZBZwRqtyO1DeaFAbPMeWjJ7Ih1AeoCd+TIGnq0OtXEVfYivSMofy?=
 =?us-ascii?Q?NQjBdetP8d4+wbqwjgQnBmwe7n5Qv1Rjxi+o4MnSw7lNBLUJybuKyEoJ7WBh?=
 =?us-ascii?Q?dSujCL1oTZtOWQEQDNITPhoyhFMMdnbyV6i5hGLhkOzW8vGJqe2vUrMic06g?=
 =?us-ascii?Q?AL07sW00SHB+fzyg37Xoj2s=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <CEEA0A4791860948B22860B82EC9DBC0@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB4858.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58767cf2-da50-4ff3-804d-08d9e018b868
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jan 2022 15:38:22.6235
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uHCAXNt/nUCWkaRXo5jky9qtdfBxEl3wb08aSeg6lqcaH3uRaKP0oK9IXtKmthqITFoNAXQaxh727XW39KQ0HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5065
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10237 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201250100
X-Proofpoint-GUID: UAMrZQh6Rq_kZPXkevpDLzb6UQZNLcOd
X-Proofpoint-ORIG-GUID: UAMrZQh6Rq_kZPXkevpDLzb6UQZNLcOd
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jan 25, 2022, at 10:36 AM, Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
> On Tue, 25 Jan 2022 10:01:38 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
>=20
>> On Tue, 25 Jan 2022 16:21:46 +1100
>> Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>>=20
>>> Hi all,
>>>=20
>>> On Tue, 25 Jan 2022 16:05:05 +1100 Stephen Rothwell <sfr@canb.auug.org.=
au> wrote: =20
>>>>=20
>>>> My qemu boot test of a powerpc pseries_le_defconfig kernel produces th=
e
>>>> following trace:
>>>>=20
>>>> ------------[ cut here ]------------
>>>> WARNING: CPU: 0 PID: 0 at kernel/trace/trace_events.c:417 trace_event_=
raw_init+0x194/0x730
>>>> Modules linked in:
>>>> CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.17.0-rc1 #2
>>>> NIP:  c0000000002bdbb4 LR: c0000000002bdcb0 CTR: c0000000002bdb70
>>>>=20
>>>> I have no idea what has caused this :-(  Maybe commit
>>>>=20
>>>>  5544d5318802 ("SUNRPC: Same as SVC_RQST_ENDPOINT, but without the xid=
")   =20
>>>=20
>>> Actually, reverting commits
>>>=20
>>>  6ff851d98af8 ("SUNRPC: Improve sockaddr handling in the svc_xprt_creat=
e_error trace point")
>>>  5544d5318802 ("SUNRPC: Same as SVC_RQST_ENDPOINT, but without the xid"=
)
>>>  e2d3613db12a ("SUNRPC: Record endpoint information in trace log")
>>>=20
>>> makes the warning go away.
>>>=20
>>=20
>> We added a new way to save items on the ring buffer, but did not update =
the
>> safety checks to know about them. I'll fix this shortly.
>>=20
>=20
> This should fix it:
>=20
> I'll make it a real patch and start running it through my tests.

Should this be squashed into the patch that adds __get_sockaddr() ?

I have an updated version of that patch that applies on kernels
that have __rel_dynamic_array.


> -- Steve
>=20
>=20
> diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
> index 3147614c1812..f527ae807e77 100644
> --- a/kernel/trace/trace_events.c
> +++ b/kernel/trace/trace_events.c
> @@ -384,6 +384,12 @@ static void test_event_printk(struct trace_event_cal=
l *call)
> 			if (!(dereference_flags & (1ULL << arg)))
> 				goto next_arg;
>=20
> +			/* Check for __get_sockaddr */;
> +			if (str_has_prefix(fmt + i, "__get_sockaddr(")) {
> +				dereference_flags &=3D ~(1ULL << arg);
> +				goto next_arg;
> +			}
> +
> 			/* Find the REC-> in the argument */
> 			c =3D strchr(fmt + i, ',');
> 			r =3D strstr(fmt + i, "REC->");

--
Chuck Lever



