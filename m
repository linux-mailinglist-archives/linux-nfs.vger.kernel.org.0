Return-Path: <linux-nfs-owner@vger.kernel.org>
X-Original-To: lists+linux-nfs@lfdr.de
Delivered-To: lists+linux-nfs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4567B576361
	for <lists+linux-nfs@lfdr.de>; Fri, 15 Jul 2022 16:06:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231843AbiGOOGi (ORCPT <rfc822;lists+linux-nfs@lfdr.de>);
        Fri, 15 Jul 2022 10:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230301AbiGOOGf (ORCPT
        <rfc822;linux-nfs@vger.kernel.org>); Fri, 15 Jul 2022 10:06:35 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C33F15FD5
        for <linux-nfs@vger.kernel.org>; Fri, 15 Jul 2022 07:06:30 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 26FE1uww010555;
        Fri, 15 Jul 2022 14:06:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=TFoDWqyzMtUfiOREzlz5a+GsD5u42V/MwAV10CT7FRo=;
 b=PfjBYznM7q2UyBYs8dk8dPfLM+m0LiV5C3X0G1GPLbYZd0Yj7zZbHbvQnxWHOtCUbfDo
 aA98CKBrlejjaBNXWWk9+BQPuCybQPRlmvHE68YAdtohnfxADnDqIiqvKqXxtzQqGtCS
 CPXOIdi8e6PiTl67QttOAVPDtOICdoCYFMAXH36d5iG/J3AYw55kWzRmqCTsqGFMGCiB
 4pILhnlX+Z8vI5FHPFGEqWRFOOH6jM34jJPfnYAyMJVC80jF6zr/77Mj2PwP6SxnN4LN
 ukgO7VugmI6XA8pSN4YtFTXHfIGF7jR+MM+mdu+7ElehGTsjle9/eIaHH0l0b/lfr/Jp MQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3h71scg4t9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jul 2022 14:06:18 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 26FE1Uj6020097;
        Fri, 15 Jul 2022 14:06:18 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3h7047hmrq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 15 Jul 2022 14:06:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DAW8BEwJfeMjf9E46eAB+4DpshK2eieEQuiViHhP9oD2oIhgkLLSdc1SAWrmfthPdcYmffmP95dNeWxNiXNjzQhTTWOzCd0UvYXfXe0kFW4r089V/oagmvUKvjyT7mclvkJLCxkgE2n6QBIsWv71gJ+MmIOxNH7WMVD9NyqXDstGUi8WLr6VqeY1/3ip6QvgJOcbBU4DJA7QkCHWeBDUaLNdEwLbynD549CV49PAIo3tls72/xmHRbL3VQwDvYI9AhNStP8HH0pDM5TCdjTcRPPjFex2xzTJYCT32ReE9SqVgc8kfGmX7ln/v5HTUh259YinlL52x58F4O6EWRJV7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TFoDWqyzMtUfiOREzlz5a+GsD5u42V/MwAV10CT7FRo=;
 b=UsHsI9JwthdhMalyfKOnqHUUYlfikNqwXrgQjYKLaMIFOqLLdvltwon8HBJKyX7540nEmbRoVMVznAfHbq/YfYj40zXIVXoVJfqMUqlzixX01rXvqeRaPRvVDkIXylk/a01n1WtHEF2GRogNMGTfpmjtzCD2b9ul1dytCHB5KNhAid7n2ndwPEAKP3xExEksxYEi4jPQg4a08wWVIvewp8EmhiOuhfZW9CK+g6SMOSfQiuPhC+WqvWlizNhxbt9sZt/i3cyiOmPHHF/b9m3ZuUdKKJK9KZiXjRa+X6pa4yK4FCCKwyAbcN8KB1WJnOTHXbiKceLpVgvykPfghmzcng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TFoDWqyzMtUfiOREzlz5a+GsD5u42V/MwAV10CT7FRo=;
 b=M7K4wQQFj1T18JMOMt7bIQfl2KfTYXwwEcP0YvhxIXOGTd0YW9h4LJcTV392rKyAo68fo0BhXglt1n628dFa/umVr2wchk6MnTg639pdfaUHqWZS2jW506wl4VV75DSg0bvJPvLZgtDq4JSajstD0Ip9u4IwuEFM1PhYAxrUI/I=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by MN2PR10MB3965.namprd10.prod.outlook.com (2603:10b6:208:1b8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.14; Fri, 15 Jul
 2022 14:06:13 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::8cc6:21c7:b3e7:5da6%7]) with mapi id 15.20.5438.019; Fri, 15 Jul 2022
 14:06:13 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     Neil Brown <neilb@suse.de>
CC:     Jeff Layton <jlayton@kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [PATCH 0/8] NFSD: clean up locking.
Thread-Topic: [PATCH 0/8] NFSD: clean up locking.
Thread-Index: AQHYkO+nUhzdndZueEy9RTo7pT1nKa1xiSYAgAiEbACAAMTsgIAA7tMAgACi9ACAAmEZgIAAwNYA
Date:   Fri, 15 Jul 2022 14:06:13 +0000
Message-ID: <39D88652-8163-48A6-8A7E-950C209C1FB7@oracle.com>
References: <165708033167.1940.3364591321728458949.stgit@noble.brown>
 <3FF88D5A-9DBF-4115-A31C-6C6A888F272F@oracle.com>
 <165759318889.25184.8939985512802350340@noble.neil.brown.name>
 <3C945625-ED72-4CC1-9CC0-F354FEF0C2E4@oracle.com>
 <165768676476.25184.1334928545636067316@noble.neil.brown.name>
 <13CEFBB0-45FB-4051-8F69-B41DC40CBD52@oracle.com>
 <165785256143.25184.15897431161933266918@noble.neil.brown.name>
In-Reply-To: <165785256143.25184.15897431161933266918@noble.neil.brown.name>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3696.100.31)
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3b9b05f9-2bba-4072-eb78-08da666b2d78
x-ms-traffictypediagnostic: MN2PR10MB3965:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +7JHAof7jFOtDKv0a/E+btMZop9VPoL2FeG/I39QMNiFONdCn/C5U5NK67/kzUf4rT0hKYHON8BRb7JcnpKM+H5igmtbrsgb6t51F8mOCMde1927mFDR9DhwIP06ga7/ZsoRSGdngFiGyyXV5BliNIP97aY1U1QGiox3zdcFloP1RPiDE9XQoBgXogY5pWzzLFYfhyMyog0iCXlPJlxkhOAlnTF9qM6Vr3wBvcpsdEA5dN51QP2WpY4l4MDbHCuodkWH2UZc9BK/MX6Y4WoAzdyTXz5bXewPdD269VsJEZgAC07L/vfrspq381WGxntW22bPAx3lAIANyfxKsl5G+DMrRm7yeUp09z8mlF0L7KRJ1BMonibDM3WWClgdLd0XrXHzKcpjL6hqwu18izMu5gvu43aB4P360Kh7ErC8EIFj5Nc2rBaGMoxMl3pOg/w+ExUMY1yvDlu32HfKEhpNP0y44j4EvzCEgZAeOet+31a3Lm6FgODRzvWWQ6cJmaQCk1qytU31rjG4CXMU0DY+DMEvKuyTx535nWSqYRUTWxNFgvg0owyfmyBc45yqjWGWv8IQleN2HFVaLFp6sdku66NkloH188w1o62Nuw+evpLuvym1ngrIWwLZmsn6P25rrs8SzTjGf+96W0AQJoI80o37sYrrluaUsJYdVvTfTn+WqZ8n0prS/fUsLSlD0/hO7rYmMErMaQ6n1fMkP8W6rfhHbUrL5F3I4Pqkk0Hp3AqfVbUzAelivqOK/0tdoS8I4BQMjD34CMZDPO2jqXf8kZ6YdSlDMlsllW43iDOmcn/po7+BmLMWTxaD0FLHtrewklKGwBJUHPuLhHzmwJbvlbs/XGQ1g7scHNjNgSllDuQ=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(39860400002)(376002)(396003)(366004)(346002)(136003)(38070700005)(38100700002)(2906002)(122000001)(8936002)(36756003)(66556008)(91956017)(66446008)(66476007)(76116006)(4326008)(64756008)(66946007)(41300700001)(33656002)(53546011)(6506007)(83380400001)(8676002)(26005)(6512007)(316002)(6916009)(5660300002)(2616005)(478600001)(71200400001)(6486002)(54906003)(86362001)(186003)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?/Gacfawam5J/rQOiAuHJGQWy+Pql5BBEllfYfrFpcUI8Oc5CpFN3W4d1IsDa?=
 =?us-ascii?Q?UXzNd5WcaiIuCoD6hnwxZ2KJdlFHmyM/424JdFxuQTk+mBa2GBN5yAIeDQH5?=
 =?us-ascii?Q?clvke2YJg6a62yfwubMXYuod4cEIYU8hVf7L+2/Wk/6xoT3GORB5msnwQrsr?=
 =?us-ascii?Q?TJvCJU4ZUUVewB45nipYIO/WkMCE9V0zZQ1RJhr2M7XOYErMuA9phlk3lT4C?=
 =?us-ascii?Q?9/bRfC63056wHXZ4n3J3RZT9/sqgwoA5FY3/Me67cAssebo8UMCUvwwRLtwU?=
 =?us-ascii?Q?NSDUJZ7hPCv/oyRFndV0vUYdIiKbFFYmrhFRF5e6GIbCOpgFIvlQrRX1XP9C?=
 =?us-ascii?Q?h+y0GpX/f2AosTES1WF2IMGkUxd6EhwE+2b/9DuxzsZNLpy5NwT6DWSt/54B?=
 =?us-ascii?Q?BjQkHrpxnhDPFwqH/kRLxKU7zAoUC1TxIqTbqYaDHsCKyCgulmJUgPfJI114?=
 =?us-ascii?Q?I/GoHVNdruuNy904fl0dp/hsR5Dm6EXfFFPbcTnaZR15j5gxt2icszypRlmJ?=
 =?us-ascii?Q?RZZY8ZPN4Mwuzt0OtXmRMBEWHi9WOcxh9H4TVTboxEftXyYgunlyWFUtrPMP?=
 =?us-ascii?Q?bWGtxcu3f1fTsiurwHAIPOhdQGgJltBt3axIqA44m83v2YNC/+PudIeh6gnI?=
 =?us-ascii?Q?iwbq/912kWTu47BWd5zT3WqxT3Xa3GyM2IyOrt8YtWk56HsQco109Qdsr+7t?=
 =?us-ascii?Q?deLckNTFonz3SO7tWFei1lhnLm7q/zmBfX+82Dr1DXdJAMavculxzCbkrf6F?=
 =?us-ascii?Q?495hLFDaIeRuL8qU/cWlNmt6tRmL4pkVXcZIXqAl1CJ/DjMKf+PsMdbZtsW0?=
 =?us-ascii?Q?00OmZCD5fjL3ud12mykFnrnPenJUkBlXV8lDIhyWjIueFHElCpxxdShis0KB?=
 =?us-ascii?Q?R9ah17mvSXEXfrpKKpPukx10v3aZOI1HldC43tMvCDf9ZedIES/jISKPx/JH?=
 =?us-ascii?Q?Vycm7HTFLGFoldw21P4T27jWZemn2fwETDsznKfWk1S7Dgp/2O5hMJBjlxfb?=
 =?us-ascii?Q?hapIVV8XyAv8iB9aFMr277KNuhjmPvXnhRYzF1CBNa7w8IcNutEQcv2AK37u?=
 =?us-ascii?Q?zf60CynzgdPPWdrUZg3zgB+42kLyO24MDHJ8WBijEjY1jLU2hjUlniZEdwQq?=
 =?us-ascii?Q?ak9bpGaBg0Fj7zo8QXxMDe8avkHxZUdWiwRpu6WBGg7QVAC8IUxVtEtRahI6?=
 =?us-ascii?Q?StKlhaPyV9MFlF2/0WVnvVcAtYyW9HXp/u9CBC9COvcMpabzA/y05ulCMYE7?=
 =?us-ascii?Q?+1zghEkiynp9qsaKsLKibpzbUhpPEqBVnMl1rs0c4+l1suSdTy2RLt35cMLC?=
 =?us-ascii?Q?lL39WI1wXukWtxpQK3X7E+9aZwppiwKv1M3XDCLYm3DrVHZ4+hFZtRLqEMnj?=
 =?us-ascii?Q?TS0c6DHUMtl4xkwg1c1uX6mpcQpxG/fChlIpiPJXrllf1deYTJFGbBlwggIs?=
 =?us-ascii?Q?xHRHxvRlD3tcAj7WGFfKtXoQ6552Lmyc1cHh29gUylx+1AdaLMpT5Ag4oKzN?=
 =?us-ascii?Q?EtkIx9v2eMQNWXcCCX9MRZjdQ2QREJJwBADVMEggn2xgOvgS7VCdilf85oQa?=
 =?us-ascii?Q?fYDbOFvxnYynEfUo4LXJfB3yd4UlM1MJpqx8XTIdKbOGeeJDTUyTg+6tK27F?=
 =?us-ascii?Q?bw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <07C172380C16E64D99C466C8E1F9BC02@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b9b05f9-2bba-4072-eb78-08da666b2d78
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2022 14:06:13.6154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WvVxTum7jB3R/GwuAqEB5/2oKVL46eZwwHVVsdnBymhflEywrVhrI1bSSPXGbV7DxffVNEYslmlz7OOmXKqsfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB3965
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.517,18.0.883
 definitions=2022-07-15_05:2022-07-14,2022-07-15 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 phishscore=0 mlxscore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=629 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2206140000
 definitions=main-2207150062
X-Proofpoint-GUID: o5cZp21aaCCDs7avYaCDM-jp6E7PFrUM
X-Proofpoint-ORIG-GUID: o5cZp21aaCCDs7avYaCDM-jp6E7PFrUM
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-nfs.vger.kernel.org>
X-Mailing-List: linux-nfs@vger.kernel.org



> On Jul 14, 2022, at 10:36 PM, NeilBrown <neilb@suse.de> wrote:
>=20
> On Thu, 14 Jul 2022, Chuck Lever III wrote:
>>=20
>>> On Jul 13, 2022, at 12:32 AM, NeilBrown <neilb@suse.de> wrote:
>>>=20
>>> On Wed, 13 Jul 2022, Chuck Lever III wrote:
>>=20
>>>>>> Secondarily, the series adds more bells and whistles to the generic
>>>>>> NFSD VFS APIs on behalf of NFSv4-specific requirements. In particula=
r:
>>>>>>=20
>>>>>> - ("NFSD: change nfsd_create() to unlock directory before returning.=
")
>>>>>> makes some big changes to nfsd_create(). But that helper itself
>>>>>> is pretty small. Seems like cleaner code would result if NFSv4
>>>>>> had its own version of nfsd_create() to deal with the post-change
>>>>>> cases.
>>>>>=20
>>>>> I would not like that approach. Duplicating code is rarely a good ide=
a.
>>>>=20
>>>> De-duplicating code /can/ be a good idea, but isn't always a good
>>>> idea. If the exceptional cases add a lot of logic, that can make the
>>>> de-duplicated code difficult to read and reason about, and it can
>>>> make it brittle, just as it does in this case. Modifications on
>>>> behalf of NFSv4 in this common piece of code is possibly hazardous
>>>> to NFSv3, and navigating around the exception logic makes it
>>>> difficult to understand and review.
>>>=20
>>> Are we looking at the same code?
>>> The sum total of extra code needed for v4 is:
>>> - two extra parameters:
>>> 	 void (*post_create)(struct svc_fh *fh, void *data),
>>> 	 void *data)
>>> - two lines of code:
>>> 	if (!err && post_create)
>>> 		post_create(resfhp, data);
>>>=20
>>> does that really make anything hard to follow?
>>=20
>> The synopsis of nfsd_create() is already pretty cluttered.
>=20
> Would it help to collect related details (name, type, attributes, acl,
> label) into a struct and pass a reference to that around?
> One awkwardness in my latest patch is that the acl and label are not set
> in nfsd_create_setattr().  If they were passed around together with the
> attributes, that would be a lot easier to achieve.

That kind of makes my point: using nfsd_create() for both classic
NFSv2/3 and the new NFSv4 hotness overloads the API.

But OK, you seem very set on this. So, let's construct a set
of parameters for a create operation and give the set a
sensible name. The "_args" suffix already has some meaning
and precedence in this code. How about "struct nfsd_create_info" ?


>> You're adding that extra code in nfsd_symlink() too IIRC? And,
>> this change adds a virtual function call (which has significant
>> overhead these days) for reasons of convenience rather than
>> necessity.
>=20
> "significant"?  In context of creation a file, I don't think one more
> virtual function call is all that significant?

If you consider how fast underlying storage has become, and how
fast it will become soon (eg, NVRAM-backed filesystems) then the
cost of a virtual function call becomes significant.

And note there is also control flow integrity. A virtual function
can be used to branch into malicious code unless we are careful
to lock it down correctly.

But these are details, and kind of miss my main point.


> I started writing code to avoid the function pointer, but the function
> args list exploded.  If you could be happy with e.g.  a struct
> nfs_create_args which contains attrs, acl, label, and was passed into
> nfsd_create_setattr(), then I think that would cleanly avoid the desire
> for a function pointer.

Note that my complaint was also about adding more logic in these
functions. It isn't much now, but having an "info struct" means
we can pass all kinds of junk into nfsd_create() and add lots
more exceptions to the code path.

Do you see why I really don't like this approach?


--
Chuck Lever



