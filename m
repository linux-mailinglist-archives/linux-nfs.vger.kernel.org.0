Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72AAF61068C
	for <lists+linux-nfs@lfdr.de>; Fri, 28 Oct 2022 01:52:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiJ0Xw3 (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Thu, 27 Oct 2022 19:52:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233187AbiJ0Xw1 (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Thu, 27 Oct 2022 19:52:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1AD69BFB
        for <linux-nfs@vger.kernel.org>; Thu, 27 Oct 2022 16:52:26 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29RMOQ5l025398;
        Thu, 27 Oct 2022 23:52:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=MSef9yt55iE5inXVPsU4YdilIv9kTr91zk7qAMpCs7w=;
 b=BiGMBsLrfRgNBsU3KXH8+6Od7rRUIqxC0ZtXBVJvOhfn60qMo+KzqfRa2zXOrIM4I2Nn
 34quD1er+bir2oQ+baJfSBIDXHSAcLDSN0IMTwjowAgZIaAYRO/7EbNr8FKwLbD1yhs0
 OoyxSYXlvfu7IZIT0VCF+nxxwggRxsgDjejjQULITCHPhwxxJ5PJUpXfHNRAlvZ9eggj
 /K/7Fj2saMleMB47t2tzed8EvGRA7cp/Lj0kRbcstjzP3825qG+grCcj5NtkKb/oPx0J
 dGsK/SJCL4l+ZvCzGWxRGf2dVW41LJVYYlE2aj03sRED86O+GwP72XC/3m4A4flJGRz2 +Q== 
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3kfagv3sw9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 23:52:14 +0000
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 29RLcx37009385;
        Thu, 27 Oct 2022 23:52:13 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3kfagfgsyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Oct 2022 23:52:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mTYChOInsBW3FqJrxiOFuQOZXP1ozmy/g2lJxQ/ukAl1CepRW6KGPNMBBwcM3GxgEQnY7IPTEFUEQtQTQGbdmC5Q13mpU6tx3wbh7FM1Hbsd0+XHs095nt1K1D6UbqtOxs8OaBxDk3sRqGPff+VX8oiQQKy0BR2FPg/MEOTinsE49aJNIg/AHqMApbbRgYLDIFbO9hSW47dA9I1huWstazXTVj5guyJ7KVrMTl/yjXJQqtzmbX2ar7ruWw9xSK8dEqwJQNa7lebO0RKTXxe+m6GZ+O28hotpAmIUQTpxo53YUtsupHxG/Ga6R0o4R+p5G1Mzl/Wye+BMW8AybokjPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MSef9yt55iE5inXVPsU4YdilIv9kTr91zk7qAMpCs7w=;
 b=O9Niv1HqjmT4XDaCrwLy66zw4gK/591ei/q9iEt97N/nrv/JBqTHGkOwGB2y12OIulEUPHT19DmvQcg0cOW9eUDCQKEXbJhpWdDvQkxDm/my44ef8ukSrb1rdyeXujiiKxklu0ofmf41hU6DykClsH9HTKypfzaQrwfGvqXR4OY5HiAaxyJgp1dgSE8ZIoRZyvJAHnadQ5Fjm94L3G/0Y30lJm2f+2ql1siSsmyeyaZ7RX5rd9JE21hJcC6GjQ1iIQqXwQkQiSDQW2MCSVz5KQrLaaXsNckA3CDMagHx2DPyDwbZjSg494QHGokYiB0/EtEPVcXr9iXUQCqBKEy/Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MSef9yt55iE5inXVPsU4YdilIv9kTr91zk7qAMpCs7w=;
 b=fxCkBOf+0pTkskYEEeDe1tJUnAN94bXTGmcFjNpSf1WsWrG+ezCIyxr1hOWXKp6Oocqtld7x3tMRCArxtiqjSBoBcbLvPOKpb1UBn1d1DWL/ybe3Ubmsf04BX2AezTLKQe/ZamMF55LPTaRk0bO0tGVy0sTDyPXYyIkqz2yUDB0=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB5947.namprd10.prod.outlook.com (2603:10b6:208:3d5::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.28; Thu, 27 Oct
 2022 23:52:11 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::5403:3164:f6c3:d48a%3]) with mapi id 15.20.5746.021; Thu, 27 Oct 2022
 23:52:11 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>, Jeff Layton <jlayton@kernel.org>
CC:     Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] nfsd: only keep unused entries on the LRU
Thread-Topic: [PATCH v2 2/3] nfsd: only keep unused entries on the LRU
Thread-Index: AQHY6k5kuvFkReNVOEunPzGZ9l7Pra4i0CqAgAAHXoCAAAI1gIAAD+cA
Date:   Thu, 27 Oct 2022 23:52:11 +0000
Message-ID: <AFE97DFF-1E60-4904-9AF3-092894428A0B@oracle.com>
References: <20221027215213.138304-1-jlayton@kernel.org>
 <20221027215213.138304-3-jlayton@kernel.org>
 <166690925944.13915.14734120966513564215@noble.neil.brown.name>
 <dd3936feb109857040ad79e7da47d7b7e5732a41.camel@kernel.org>
 <166691131566.13915.14122113998554165159@noble.neil.brown.name>
In-Reply-To: <166691131566.13915.14122113998554165159@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3654.120.0.1.13)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|IA1PR10MB5947:EE_
x-ms-office365-filtering-correlation-id: 118b6bb6-6840-43a9-7ed7-08dab876441e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: //k9Jr/hPbDDQ/p4BwEycJfR7tk/heSWnBbDSYTV8y+uYCLxWWdE8aNpSJbBj9hGQPjwodLAwasKAN/xJH1fg7WNIwrO3kqvzTcIJPvLM44hPBoX8yWs+Ia1e9kWo6DOdwxXev8HqL9mYLyTdSmpZei0LcI449WfV2T/AP87V1E1vxIblfsIDjtc7cpUekZqK0DWc2EVYlstfn40lJstF8Nib/gtUDYZU/DDVXMALa24M5YZMfLJ2RXNyo+7hmx5nbL330cMHfjsMJWPCUu3lsrcMzt403e1YRYqMoEQHJYb+7sikFbNhLYSxwMy3KKPLJFaKwBrIjBG1XMeuW3yi+3n0rPTNOsH30Sb+ZBcP+EMCYnFojwXlSYFHjM9/49I/0F+Fo7LglT9CWP9ptSYm10h1L0pttfkhWQjWjHKCTYKGCj8W+eGSTBUVFkEZuiKhUmSxruLO4E7BMP26kJFacTklypg9vbwPMmIsM+FAEvyXw1BfFVJPK8U97d15c1gdh3SxHi+9bGrKnXO8syDQtwBwHho913vph4ZZ0PIVtkIiTSoa5YQC43LjUfu0eyLHmMXJ2XFF1Z00t5IPTlzcYAET/cupXa5d76Nc5XTK753MA0ItqqgECCVB2APIKtNT7A37kdgKqW5CjEyQ4FC4TT3aErfoaaI8LELZugJxKVpHjiEqv9JCx0MNOLIqh9OvJpe1vFarjLgxhPAqT+q6XKhVVLA2QJpYkgNACW4pR02O/gbHqEjxp5TMcAD9M23oEaLMdrStKIQZEJl/3dS4RfJWockiRdZAd/xOqthOYQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(376002)(396003)(136003)(346002)(366004)(39860400002)(451199015)(6512007)(2616005)(64756008)(4001150100001)(66476007)(71200400001)(91956017)(33656002)(41300700001)(2906002)(66946007)(4326008)(66556008)(5660300002)(8676002)(478600001)(6486002)(110136005)(38070700005)(316002)(83380400001)(76116006)(38100700002)(66446008)(53546011)(6506007)(26005)(122000001)(86362001)(36756003)(186003)(8936002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?vEQzX70uwOCs463Y6hnPT2ASggKF18WB/ICRZr0nBNH/o3xOHzDq3PnipIBP?=
 =?us-ascii?Q?lABMNW33CKP6vuAuoKcxatF6sl2AT6oJv9gzpC5o3XnZF3YtOqr+fwwSH18L?=
 =?us-ascii?Q?PPlm5cHVh2IotDisDVhC2omLxw87FsyDlha40zZkJG4/2TN1O2wJcceNyHRV?=
 =?us-ascii?Q?DAcJGIhiX2nFpM47S3leE3jQswM55iDR1xTinuNrYOURHLWaOjKIM26obwmw?=
 =?us-ascii?Q?GGOEZ2ir65xdKnyjY1iTxZBYpZBRTJtkMZ6Q99P/640sjrZJDMHo2aKk2uFg?=
 =?us-ascii?Q?A28GldLsLsASAWouSOLCvn6gNoymOW/aakkWLBdxNTHomNMJ9RgZ3r4xXwD+?=
 =?us-ascii?Q?7kHkusQvu3gpQsVjqLS2SD57cRKpH8qQB1dWat5DLSlxnyNQ0W3IuH1CQIt8?=
 =?us-ascii?Q?pXrSS5NgPhea+dZCqhJCvwP2EiT8nZfk9YrOwy6VEux9Js5Z3anqEvK02w9X?=
 =?us-ascii?Q?dek/5Ks1p2Nw2LlQekDyqBYNBiZa61aCZ65L2K4sRy+TLudz2ieLl7eFreNU?=
 =?us-ascii?Q?7DaXJ60EePvDDqqaeDNi7UPE6JlH3sCeOm02aYoXOVo2MgXjPRv1yFZor4lu?=
 =?us-ascii?Q?K7BuPkvZLHAOCP8ky1+O5YnzRER/cyLw9PMrPn1t3GbYlN84ugbFVFco9pzh?=
 =?us-ascii?Q?3MKgtvA1AX8NyzWBsdXwJtsa5QUFIiLyjfnTjcKH9ps0haUZMvtg0rJF/7Tb?=
 =?us-ascii?Q?RFBFLavu5QX5aKduouQPFXm9cWpl+OTT87+ipL2tC+NC7mpEurXhnmcpQDAo?=
 =?us-ascii?Q?Wr2JLe0iSf+xMf055lijTPmcNJEmxe0Aecj4fgzd/skE4WumOWbyfhqTjOUc?=
 =?us-ascii?Q?HaAmfZQGk1c3mQgS61nWFamSUlR5tyBGDiJoUYwZraAOa6Vvwc8/R4xiaufO?=
 =?us-ascii?Q?4z5J9zn7G7Ao8e4iJIMxg5jcxqkMxsRTwrrbdydXBY63Kxbx/6kmmilYYzj1?=
 =?us-ascii?Q?t3lqM4FfpUZ0FSmBAP6Nd2S0A9/Kx7JIghPrcGQwZw3kftDcKHjUJCMcpV8H?=
 =?us-ascii?Q?qvjXhouFfn2WqAS73HIuE6ByIHjH7MLKB56ECYxEFsyZV+1hMyde1OI2fIcF?=
 =?us-ascii?Q?YDJNrgt1485clC+Flw4/xorZDD5q/yNKjdkH4Sehdg+9RVDNEUtP2JtxhjIp?=
 =?us-ascii?Q?TZ2LgPj6+FTRGDoAr7hl4xsy2eeQsIxceQSNYRTfmDQQOHweLKyBusNhCU7j?=
 =?us-ascii?Q?cxMOvQn9vJ/Yei3oEEv2dgOXJCweT7RnyoT1VPAMCUrFW7/wFlCYlxaobZsr?=
 =?us-ascii?Q?7gWyueFtzKowjY6K6HvW2ys0wHU4iCgESrXip0p93FRPRMZ3FAq6BrHGqz5y?=
 =?us-ascii?Q?QNSe4XAxp+RJnL8Jaojzlmhnkvjnrv1pWAtba1VwgW/3yEQpS00rr9RSH1Lv?=
 =?us-ascii?Q?sw+DpQ9s85HAG84adXeL/P4V/nf8bGnYYIByPo7AYOQJQDhXJK7MSFrRYV4L?=
 =?us-ascii?Q?Jh/6YaFkPLeo0cSidXbbKxqPHq47Mx1NH4VU/sDElBUG2Nnq9Mk6pAnITQoy?=
 =?us-ascii?Q?ytjFrYMWS8TTUZnIYNwzKd+h4Q8kRh4gj9LP+CGWOLUQwV7d/4Q1NMY39kCn?=
 =?us-ascii?Q?6iMhRzmST7KyLqUnXGH2AQk1ydrOyonXlk72flF4602gZkSThHpWfjuG77Bt?=
 =?us-ascii?Q?4w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <14043F8BBF525F499EA799419295589D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 118b6bb6-6840-43a9-7ed7-08dab876441e
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Oct 2022 23:52:11.2504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QrG/2h3ftqIrQkiH84gcnZcHj79SRytwPO/lOnaH4uE/TfPRUpO2449Tr4rumH9FcSyVotFWHe3LalFpQB666A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB5947
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-27_07,2022-10-27_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 mlxscore=0 spamscore=0 phishscore=0 malwarescore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2210170000 definitions=main-2210270135
X-Proofpoint-ORIG-GUID: YpZqVcGHUi-eHE1nXnjOSTtiKDOP4esE
X-Proofpoint-GUID: YpZqVcGHUi-eHE1nXnjOSTtiKDOP4esE
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Oct 27, 2022, at 6:55 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Fri, 28 Oct 2022, Jeff Layton wrote:
>> On Fri, 2022-10-28 at 09:20 +1100, NeilBrown wrote:
>>> On Fri, 28 Oct 2022, Jeff Layton wrote:
>>>> Currently, nfsd_files live on the LRU once they are added until they a=
re
>>>> unhashed. There's no need to keep ones that are actively in use there.
>>>=20
>>> Is that true?
>>> nfsd_file_do_acquire() calls nfsd_file_lru_remove()
>>> Isn't that enough to keep the file off the lru while it is active?
>>>=20
>>> Thanks,
>>> NeilBrown
>>>=20
>>=20
>> After patch #1, it doesn't call that anymore. That's probably a (minor)
>> regression then.
>=20
> Yes, I eventually found that - thanks.
>=20
>>=20
>> After patch #1, the LRU holds a reference. If you successfully remove it
>> from the LRU, you need to transfer or put that reference. Doing the LRU
>> handling in the get and put routines seems more natural, I think.
>=20
> Maybe.  But then you need a __get as well as a get.
> Though it might seem asymmetric, I would prefer removing from the lru in
> 'acquire' and adding to the lru in put.

That's exactly the design introduced by commit 4a0e73e635e3
("NFSD: Leave open files out of the filecache LRU"). I also
would like to keep that behavior -- that's what a real LRU
is for.


>> Maybe I just need to squash this patch into #1?
>=20
> Or do the "put" if lru_remove succeeds in the first patch.  Then revise
> it all in the second.
>=20
> Thanks,
> NeilBrown
>=20
>=20
>>=20
>>>=20
>>>>=20
>>>> Before incrementing the refcount, do a lockless check for nf_lru being
>>>> empty. If it's not then attempt to remove the entry from the LRU. If
>>>> that's successful, claim the LRU reference and return it. If the remov=
al
>>>> fails (or if the list_head was empty), then just increment the counter
>>>> as we normally would.
>>>>=20
>>>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>>>> ---
>>>> fs/nfsd/filecache.c | 23 ++++++++++++++++++++---
>>>> 1 file changed, 20 insertions(+), 3 deletions(-)
>>>>=20
>>>> diff --git a/fs/nfsd/filecache.c b/fs/nfsd/filecache.c
>>>> index e63534f4b9f8..d2bbded805d4 100644
>>>> --- a/fs/nfsd/filecache.c
>>>> +++ b/fs/nfsd/filecache.c
>>>> @@ -420,14 +420,31 @@ nfsd_file_unhash(struct nfsd_file *nf)
>>>> 	return false;
>>>> }
>>>>=20
>>>> -struct nfsd_file *
>>>> -nfsd_file_get(struct nfsd_file *nf)
>>>> +static struct nfsd_file *
>>>> +__nfsd_file_get(struct nfsd_file *nf)
>>>> {
>>>> 	if (likely(refcount_inc_not_zero(&nf->nf_ref)))
>>>> 		return nf;
>>>> 	return NULL;
>>>> }
>>>>=20
>>>> +struct nfsd_file *
>>>> +nfsd_file_get(struct nfsd_file *nf)
>>>> +{
>>>> +	/*
>>>> +	 * Do a lockless list_empty check first, before attempting to
>>>> +	 * remove it, so we can avoid the spinlock when it's not on the
>>>> +	 * list.
>>>> +	 *
>>>> +	 * If we successfully remove it from the LRU, then we can just
>>>> +	 * claim the LRU reference and return it. Otherwise, we need to
>>>> +	 * bump the counter the old-fashioned way.
>>>> +	 */
>>>> +	if (!list_empty(&nf->nf_lru) && nfsd_file_lru_remove(nf))
>>>> +		return nf;
>>>> +	return __nfsd_file_get(nf);
>>>> +}
>>>> +
>>>> /**
>>>>  * nfsd_file_unhash_and_queue - unhash a file and queue it to the disp=
ose list
>>>>  * @nf: nfsd_file to be unhashed and queued
>>>> @@ -449,7 +466,7 @@ nfsd_file_unhash_and_queue(struct nfsd_file *nf, s=
truct list_head *dispose)
>>>> 		 * to take a reference. If that fails, just ignore
>>>> 		 * the file altogether.
>>>> 		 */
>>>> -		if (!nfsd_file_lru_remove(nf) && !nfsd_file_get(nf))
>>>> +		if (!nfsd_file_lru_remove(nf) && !__nfsd_file_get(nf))
>>>> 			return false;
>>>> 		list_add(&nf->nf_lru, dispose);
>>>> 		return true;
>>>> --=20
>>>> 2.37.3
>>>>=20
>>>>=20
>>=20
>> --=20
>> Jeff Layton <jlayton@kernel.org>
>>=20

--
Chuck Lever



