Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 520DC466686
	for <lists+linux-nfs@lfdr.de>; Thu,  2 Dec 2021 16:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237640AbhLBPhA (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 2 Dec 2021 10:37:00 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:6628 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237534AbhLBPg7 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 2 Dec 2021 10:36:59 -0500
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1B2FLiru020410;
        Thu, 2 Dec 2021 15:33:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=amHnWDNz/Rq2MHxrFfXSr7Ok5y0KWFl2HazD6dvTZ5s=;
 b=cC5vy0Cg+97RhN1wd02pX2c7/xdvJ6rPdl7AEXMoF5OSXaQ6SMmTicpCuMZwp9FMkIRv
 SwmvwATLeJhLEzAEYdbLmivUwsyeuPGp4Lqlim+DZinZGIz27SEP/fE47YO6NSUe1J5/
 FesgpjRbCjh15moS2D5NtCHZtpAe6IUk8amyyorn6O6EWwCsSWmZFVZpIvyIIDKK3+oB
 /S/U+AEjhQjNp+4BnNqwcWdKk4On1e5Qjpfty24wAhFvUe9ioJvGoYCv7VH8E59zJqKv
 K54TyLNFHc2XHg+/7BhqlgWc90bVI0NgoKqXfIRSGOIYClGxNP2tH21YON/rvSojH/M0 Kg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cp9r58ad4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Dec 2021 15:33:25 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1B2FVZCg057902;
        Thu, 2 Dec 2021 15:33:24 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam07lp2047.outbound.protection.outlook.com [104.47.51.47])
        by aserp3030.oracle.com with ESMTP id 3ckaqjpsab-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Dec 2021 15:33:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eSJ+hmedHDIp7W+7aeAxAJxCOVMZfSgfjxchtgGHehjgg+6VKP8smnZvSc4hUDRkYGaR3X0icezqPVKUYf3/B39PP0tMUaxWjpU/1eCpss9wO0Ae8y2JPzqvykAMZ9Rek2KDS/85xCkQ/G+jeEbVftnyy5tpgsf/Mhicvb1itF1U5AmXKdmvNHZRORcqmE5K4h6bDsnRmd1HTl7R0VKVoNWnDnl+dZZ+Dus0owymDg3NQbr9cOATRwUtk2nPR7N546V9iv0e+rZv4UcB3S8z/TOAgMni6y/Ahc1pC+ZYcM8BcksEsClN6QKevdihtuKtR8HCyhEr+63M7idVuejPUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=amHnWDNz/Rq2MHxrFfXSr7Ok5y0KWFl2HazD6dvTZ5s=;
 b=dpDlWTU1I77JMaTv5Bjb34/7Z0nFvxKd6+0WH4snXVJF0Qggu0hJr96MDfSR+U7/ki5jG/D6iLWCLUWU7JAgBiUhPOATdk1xMcNIcMm+glgBOpaqscotvxFj0ew3N/i+koPWEEt+wZd7H4nAQp1EZFPXVGy/rtgTfEtuXpOvlUfqHnt/Q6h41/QjfrmPn3XE3NS9NPII7ZBVYY9mw6nEemKiFx+UHdCZt8bphqF0j97WK3QP+gHGcCS9jF1jrx/XZ9O0aHaf0Vl7kcsTxRk0oXVQUensS33FVA0yC+EispSV8LlhWw6zAonLP4CJOHxeJEVwJTkFqDlJI8+Yjde9aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=amHnWDNz/Rq2MHxrFfXSr7Ok5y0KWFl2HazD6dvTZ5s=;
 b=jCR2/zquPtstIDQ26/O0edhoIN4G/KDcr9CWLVfUPFXIN/T6AgvYPHt+HpDtrWtYGOdzXFP/TfvrspJCCfcC+7PaFbTuNf9v98Q+95k8aFKPMaWF7Hf7ZwB5PRJ2DI1zroznqWF6V4OEx9PB1zCvARPxsUDA0fnVPtW6FnstcDM=
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com (2603:10b6:a03:2db::24)
 by BYAPR10MB2568.namprd10.prod.outlook.com (2603:10b6:a02:b1::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Thu, 2 Dec
 2021 15:33:22 +0000
Received: from SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::48f2:bb64:cb4b:372f]) by SJ0PR10MB4688.namprd10.prod.outlook.com
 ([fe80::48f2:bb64:cb4b:372f%9]) with mapi id 15.20.4755.016; Thu, 2 Dec 2021
 15:33:22 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Trond Myklebust <trondmy@hammerspace.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2] NFSD: Fix RCU-related sparse splat
Thread-Topic: [PATCH v2] NFSD: Fix RCU-related sparse splat
Thread-Index: AQHX5XDFTrw4hMDSskyK33okWYrHZawcrx4AgAAMIoCAAAzJgIAAFXYAgAJ7f4A=
Date:   Thu, 2 Dec 2021 15:33:22 +0000
Message-ID: <CA08837F-AE63-492F-865D-CCA71AFB0B2C@oracle.com>
References: <163821156142.90770.4019362941494014139.stgit@bazille.1015granger.net>
 <20211130225250.GC641268@paulmck-ThinkPad-P17-Gen-1>
 <163831537509.26075.12859361728901873347@noble.neil.brown.name>
 <2ABC02B1-CE76-422A-B64F-64B108B12C0B@oracle.com>
 <163832273051.26075.5034720991945492453@noble.neil.brown.name>
In-Reply-To: <163832273051.26075.5034720991945492453@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1b5a83db-3c8c-4656-62e0-08d9b5a91328
x-ms-traffictypediagnostic: BYAPR10MB2568:
x-microsoft-antispam-prvs: <BYAPR10MB2568916B6A21F9E9824DC0F493699@BYAPR10MB2568.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: D9/sTEmXNC1c5G/0aPeZett9tbx7YYA2Y/yrLNsqSh/0aNT/lX+33lFEypUmqiLM/UDfTcaN0vrV1mz7Gs7TwDmZsUKd+J8+sqmq7Uh6pJD5GBT3eySbB3yPsl700RfN8QxwzLZKkMtPNG6JM1e8Yg6RqjkFIrCu7yilg0QtZB0sVbuLjFk9g2BmqHP++D+n/IpntZcRUtBH0A9t9j80t8/ptSNCxFVTrKpJrXqTiSuoj3aAv1lHK0QsxRqnCwJ3aFmeV8cnxEL35s5ePCZraIDP+DuB1lWKHLsDu8dUd7Rdp4mbzOshiMziFbTWpUcaZUhiq/Lz8SlMiV/jRMsgzoFQ1e8fxxlhPMdrMIKXjZZfdL9DN7bAeWh+k2HpaDhqcE4VQuCfCirB6uXHcGWuy/d2IMXKHKWtd19UmKXzZlo17P4gZQ5+W9xso+3/cyiDPd575QGlkc3VrB/V6q2xL7OIWCGtgpVigiRRN0P7LuZutfAYJCsHW+S59r9NplyhOyrmlhGrgxTnaRoAH4iPt8NprH2ccsz37I4TfBosRhY2lx7BU1jONszfAdI7PQLc63eV18OifR6rSUxJA63fILMLCe7AfR+XUIkj237hYPw+0tDuOI0wFy78ovBVTn9VADW+Y2uxJSF6qnRuNsXF/RFhsRzg6x//139Ab+aISJBlfeqlmXrnZibvO76BqOblAr2sUxolBITavQh8yTNUXTdEdB6nFc8FKkKJJRmWHTu59VM4d0YrWw9OjJtToRH6hToP4UJXkBkwU21eSrT93acAUyLQh4n+Xy+VFxuSg/cqu7zgRsfwH+v0gDuDV4kGmL1UDyOFbBVzrcshqXi+Ng==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4688.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6512007)(54906003)(91956017)(38070700005)(33656002)(2616005)(316002)(86362001)(76116006)(186003)(8936002)(36756003)(966005)(26005)(6506007)(4326008)(122000001)(66476007)(66446008)(5660300002)(6916009)(508600001)(2906002)(66946007)(83380400001)(66556008)(38100700002)(8676002)(64756008)(53546011)(71200400001)(6486002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?E2UGeAcd8uHszlyy8uTV5NYBRvjKlpWsZNzyt4cqsJIzpHLTcxY84t6WPD/z?=
 =?us-ascii?Q?mQ7o6F8yOsRj1ldInJdT+j5DfqVqbQb/ruevV43WSvuHLoiZw8PIX99zyRBa?=
 =?us-ascii?Q?rer+xvzggcjyr4MNID5XHGt0urAQbQSouD8mI0Lu3dATlbLF4HcpR1gw5MzL?=
 =?us-ascii?Q?+EiKQnI98JYDf4D/4pPvFMs6gCWF61vhDP5tziSGk2N0pEGWubXb2XfG/Gcc?=
 =?us-ascii?Q?3AOqPfJi02Hu/WWXdJJ/whw+LIpHyTonaexv0buuXoX3Dpb+wnP11PkU4VTa?=
 =?us-ascii?Q?DQy7/Ff7Vw9QVY9pZu1U485SxfBS9atvwmsEl07E27IMgK9qqfT0a2K1LYv4?=
 =?us-ascii?Q?Yx0KrPwFH4a55IovLQuEYv8Ju4u/PmTKEheQ1aRGic1d9O2pypmXY0lGcq9t?=
 =?us-ascii?Q?Xwd49XhmjIDIraCtM7pwrMoMLDtq2SO22Fxa7Ee9sWxSbXpGJmlcBRc0GaZo?=
 =?us-ascii?Q?e4Lo8GJhI44rv/2a1XlhNWGj53Zmhot6cqZIMChAPtqrjxQMcbI24JxF0/Ra?=
 =?us-ascii?Q?qOc7DCO234iBg5hDDupoaIl0pNJzq5amVtKHqhrTF8R6ps1hcHs4gEkG4wsC?=
 =?us-ascii?Q?lY4BvnrUlarX4Mu4TFCz82PBIXz0XZtVSWT1uEb6q8gGx7QQveQEIrVnjaR8?=
 =?us-ascii?Q?tZQsmZ4GLGK8Psn/AlDKYCj7ryzzQdUzU0DKs+RjWm6J0wztxidv7a7XHgE9?=
 =?us-ascii?Q?Xn8Ie2F9yupnUdkZGGy360whDcsT43Frkv4x9HJaNgdV2HHt4vQBq0NiBMfo?=
 =?us-ascii?Q?4UuIjG9GVFQf3qZuNvacpSmZ2DpdJgu1j1GRSuywi9wb/pHpB+dH9L4xRTS6?=
 =?us-ascii?Q?A6whcGvMHaC0SoEa/JJaDMU/7+Soy6vOoDI4q3swpQlIT0amPIAONIlk6hC3?=
 =?us-ascii?Q?SUsRWUsYe9RBel8BWJKWbrNt0UXJD9uFlhDJSFDtIeTpGH7fPWHP91hxvwZH?=
 =?us-ascii?Q?rJOYHaS26E/NMY1cEywaSM9x6fmPFYtYi4oFU6iF0RO6fao2jRm2VzPElkiQ?=
 =?us-ascii?Q?SQ2DX6QsfyhajZ8+kJ/YTfBZi+9G0euzF1oEoDKCz/T2ie7tCf767Yod2OX7?=
 =?us-ascii?Q?4mErvxlt8uPGIvQ8wFGa4hL1VddtVzuGLTncYSjlbBKPoefmizJggZXjvyu4?=
 =?us-ascii?Q?xUEQ7Glil80aEi2jRIXPFrhWl4YH1vBpxA1rmOd7QnVjyaIbnbwauKTXiODX?=
 =?us-ascii?Q?Ja9aJ7xfHK5iNe73ZU/zn1Y94f6RoyeSMmPCxHZjcF2DC7lqmflOiygIFzo6?=
 =?us-ascii?Q?tBFPfAUD2ESwaOB7riIyUpccZNEB40lKhU1S1GAB+EcRH4fLTt3JeHvFNOny?=
 =?us-ascii?Q?Ib/UXlgxqzT11OTM6OU5QzgQOWDxT5QymZAMiSGFySaqJDaNMM/KHT/NiyWD?=
 =?us-ascii?Q?ZBaoQ8G7HyWRvOdZnM7+1Effzx3T+g+9Uly1w+1UwW+lFRVcrXSqvSoZnG2x?=
 =?us-ascii?Q?/fQhoqSllySTA36iyRVdQR7890CCTrZ1xYFjVBGnvqTAIY0O/pTqomG2wwWa?=
 =?us-ascii?Q?0nyLNuPzdc4v+Iv0RE3U3EIJ+PQLuR1s+WjaDJAhKMn+1b7rzVVAmsFku3VL?=
 =?us-ascii?Q?2yyFXDJ7e9bOiql+IMALYyjF9FBDHLHFpCld32EVv+okiX1aL3IGO30BJ1wU?=
 =?us-ascii?Q?VmoelV39CUOAbMVyBc0Ix/Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <C0A2D3C639D4594B8717D843047DB8F3@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4688.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b5a83db-3c8c-4656-62e0-08d9b5a91328
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2021 15:33:22.3875
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hqCQBwMAWR/GF/YjCR8p44Cd/C+1tzQwaX5esAav2J9V21miH4EEpRR4bN48URjsKv5y+t9eIA19hZVinZjnDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2568
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10185 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2112020102
X-Proofpoint-ORIG-GUID: V5vCdFagETgHfdk-m6KFTO9WEUXy8gzV
X-Proofpoint-GUID: V5vCdFagETgHfdk-m6KFTO9WEUXy8gzV
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Nov 30, 2021, at 8:38 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Wed, 01 Dec 2021, Chuck Lever III wrote:
>>=20
>> By way of further explanation:
>>=20
>> The Documentation/ for RCU (ie, "RCU for Dummies") suggests that
>> rcu_assign_pointer() is adequate for preventing undesirable
>> compiler optimizations or CPU load/store reordering.
>>=20
>> rcu_assign_pointer() uses WRITE_ONCE for constants like NULL and
>> smp_store_release() when assigning variable values. I copied the
>> use of WRITE_ONCE() from rcu_assign_pointer(). So I expect exactly
>> zero change in behavior or compiled code... (but I should have
>> checked the generated object to verify that is the case).
>=20
> True, there would be no change in behaviour - but we should at least ask
> if that behaviour is correct, and why.
>=20
> If any barriers are needed here, they would have to be between the
> assignment of NULL here, and the tests of l->net in
>   nfsd_file_list_add_disposal()
>   nfsd_free_fcache_disposal_net()
> (because they are the only places ->net is used)
> The only conceivable race is that they will see a value in ->net "after"
> NULL has been assigned.
> If there were a race there, it would be between different cpus, so
> smp_store_relase() and smp_load_acquire()
> would be the correct tools to avoid that race.

smp_load_acquire() is not used in those functions, so one might
draw the conclusion that either the RCU annotations are incorrect,
or that degree of concurrence paranoia (including using
rcu_assign_pointer() to assign the NULL) is unnecessary.


> If, on the other hand, there is no chance of a race, then there is no
> need to assign NULL to ->net at all.  I believe this is actually the
> case.
> As the 'net' is freed using kfree_rcu, there is no possibility for a
> search that started before something was removed from the list to get a
> false-positive when testing if l->net =3D=3D net.
>=20
> So while your change is safe from a behavioural perspective, I don't
> think it is safe from a maintenance perspective because it leaves in
> place code that doesn't really make sense, but removes the warning that
> helps us to find that nonsense.

Well I agree that the code is either hard to follow, incomplete,
or incorrect, and therefore needs to be cleaned up so it does not
accrue further technical debt.


>> Sure. If it makes sense to use nfsd_net instead of a separate data
>> structure, then that can be made to happen. I would like to hear
>> from Trond regarding why he felt a separate data structure was
>> necessary for fcache_disposal.
>=20
> That would be best, yes.

Since Trond was active recently, I think we can conclude from his
silence he does not care and we are free to act as we see fit.

I'm comfortable starting with https://lore.kernel.org/linux-nfs/16383166945=
5.26075.14420575954675785122@noble.neil.brown.name/raw

--
Chuck Lever



